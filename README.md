# Device Info App

[![pub package](https://img.shields.io/pub/v/device_info_app.svg)](https://pub.dev/packages/device_info_app)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.3.0+-blue.svg)](https://flutter.dev)

A comprehensive Flutter plugin for retrieving detailed device and application information across Android and iOS platforms. Get device model, app version, locale information, and much more with a simple, type-safe API.

## ✨ Features

- 📱 **Device Information**: Model, brand, platform version, unique identifier
- 📦 **App Information**: Version, build number, bundle identifier, display name
- 🧠 **RAM Information**: Total RAM, available RAM, used RAM, memory usage percentage
- 🌍 **Localization**: Device locale, timezone, country codes
- 🔒 **Type-Safe**: Strongly typed Dart models with null safety
- 🚀 **Cross-Platform**: Full support for Android and iOS
- ⚡ **Performance**: Efficient method channel communication
- 🛡️ **Error Handling**: Robust error handling with fallback values

## 📱 Supported Platforms

| Platform | Version | Status |
|----------|---------|--------|
| Android  | API 21+ | ✅ Supported |
| iOS      | 11.0+   | ✅ Supported |

## 🚀 Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  device_info_app: ^1.0.1
```

Then run:

```bash
flutter pub get
```

## 📖 Usage

### Basic Usage

```dart
import 'package:device_info_app/device_info_app.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _deviceInfoApp = DeviceInfoApp();
  DeviceInfo? _deviceInfo;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  // Helper function to format bytes
  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  Future<void> _loadDeviceInfo() async {
    try {
      final deviceInfo = await _deviceInfoApp.getDeviceInfo();
      setState(() {
        _deviceInfo = deviceInfo;
      });
    } catch (e) {
      print('Error getting device info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Device Info')),
        body: _deviceInfo == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('App Version: ${_deviceInfo!.versionNumber}'),
                    Text('Build Number: ${_deviceInfo!.buildNumber}'),
                    Text('App Name: ${_deviceInfo!.displayName}'),
                    Text('Bundle ID: ${_deviceInfo!.bundleName}'),
                    Text('Device UUID: ${_deviceInfo!.uuid}'),
                    Text('Locales: ${_deviceInfo!.locales}'),
                    Text('Time Zone: ${_deviceInfo!.timeZone}'),
                    Text('Country Code: ${_deviceInfo!.alphaCode}'),
                    Text('Language: ${_deviceInfo!.localeApp.languageCode}'),
                    Text('Country: ${_deviceInfo!.localeApp.countryCode}'),
                    const SizedBox(height: 16),
                    const Text('RAM Information:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('Total RAM: ${_formatBytes(_deviceInfo!.totalRam)}'),
                    Text('Available RAM: ${_formatBytes(_deviceInfo!.availableRam)}'),
                    Text('Used RAM: ${_formatBytes(_deviceInfo!.usedRam)}'),
                    Text('RAM Usage: ${_deviceInfo!.ramUsagePercentage.toStringAsFixed(1)}%'),
                  ],
                ),
              ),
      ),
    );
  }
}
```

### Advanced Usage

```dart
// Get device info with error handling
Future<void> getDeviceInfoSafely() async {
  try {
    final deviceInfo = await _deviceInfoApp.getDeviceInfo();
    
    // Check if running on specific platform
    if (deviceInfo.locales.contains('Android')) {
      print('Running on Android');
    } else if (deviceInfo.locales.contains('iOS')) {
      print('Running on iOS');
    }
    
    // Access detailed locale information
    final locale = deviceInfo.localeApp;
    print('Language: ${locale.languageCode}');
    print('Country: ${locale.countryCode}');
    
    // Monitor RAM usage
    print('RAM Usage: ${deviceInfo.ramUsagePercentage.toStringAsFixed(1)}%');
    print('Total RAM: ${_formatBytes(deviceInfo.totalRam)}');
    print('Available RAM: ${_formatBytes(deviceInfo.availableRam)}');
    
    // Check if device has low memory
    if (deviceInfo.ramUsagePercentage > 80) {
      print('Warning: High RAM usage detected!');
    }
    
  } on PlatformException catch (e) {
    print('Platform error: ${e.message}');
  } catch (e) {
    print('Unexpected error: $e');
  }
}

// RAM monitoring example
class RamMonitor {
  final DeviceInfoApp _deviceInfoApp = DeviceInfoApp();
  Timer? _timer;
  
  void startMonitoring() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      final deviceInfo = await _deviceInfoApp.getDeviceInfo();
      print('RAM Usage: ${deviceInfo.ramUsagePercentage.toStringAsFixed(1)}%');
      
      if (deviceInfo.ramUsagePercentage > 90) {
        print('Critical: RAM usage is very high!');
        // Implement memory cleanup logic here
      }
    });
  }
  
  void stopMonitoring() {
    _timer?.cancel();
  }
}
```

## 📚 API Reference

### DeviceInfoApp

The main class for accessing device information.

#### Methods

##### `getDeviceInfo()`

Returns a `Future<DeviceInfo>` containing comprehensive device and app information.

**Returns:**
- `Future<DeviceInfo>` - Device and app information

**Throws:**
- `PlatformException` - If the platform doesn't support the operation

### DeviceInfo Model

The data model containing all device and app information.

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `versionNumber` | `String` | Application version number |
| `buildNumber` | `String` | Application build number |
| `displayName` | `String` | Application display name |
| `bundleName` | `String` | Application bundle identifier |
| `uuid` | `String` | Device unique identifier |
| `locales` | `String` | Device locale information |
| `timeZone` | `String` | Device timezone |
| `alphaCode` | `String` | Country alpha code |
| `localeApp` | `LocaleApp` | Detailed locale information |
| `totalRam` | `int` | Total device RAM in bytes |
| `availableRam` | `int` | Currently available RAM in bytes |
| `usedRam` | `int` | Currently used RAM in bytes |
| `ramUsagePercentage` | `double` | RAM usage percentage (0-100) |

### LocaleApp Model

Contains detailed locale information.

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `languageCode` | `String` | Language code (e.g., 'en', 'es') |
| `countryCode` | `String` | Country code (e.g., 'US', 'GB') |

## 🏗️ Architecture

This plugin follows Flutter's recommended plugin architecture:

- **Platform Interface**: Abstract interface defining the contract
- **Method Channel**: Cross-platform communication layer
- **Native Implementation**: Platform-specific code for Android and iOS
- **Type-Safe Models**: Strongly typed data models with null safety

## 🔧 Development

### Prerequisites

- Flutter SDK ^3.3.0
- Dart SDK ^3.9.2
- Android Studio / Xcode for native development

### Building

```bash
# Get dependencies
flutter pub get

# Run tests
flutter test

# Build example app
cd example
flutter run
```

### Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Support

- 📧 Email: [nguyenngoctuyen188@gmail.com]
- 🐛 Issues: [GitHub Issues](https://github.com/MrTuyennn/device_info_app/issues)
- 📖 Documentation: [pub.dev](https://github.com/MrTuyennn/device_info_app)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Plugin platform interface for the architecture pattern
- Community contributors and testers

---

Made with ❤️ by JunCook

