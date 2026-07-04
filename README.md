# Device Info App

[![pub package](https://img.shields.io/pub/v/device_info_app.svg)](https://pub.dev/packages/device_info_app)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.3.0+-blue.svg)](https://flutter.dev)

A comprehensive Flutter plugin for retrieving detailed device and application information across Android and iOS platforms. Get device model, app version, locale information, RAM/disk size, build info, and much more with a simple, type-safe API.

## ✨ Features

- 📱 **Device Information**: Model, brand, manufacturer, system name/version, unique identifier
- 📦 **App Information**: Version, build number, bundle identifier, display name
- 🧠 **RAM Information**: Physical RAM, available RAM, low-RAM device flag
- 💾 **Disk Information**: Free and total internal storage size
- 🌍 **Localization**: Device locale, timezone, country code, and derived international dial (area) code
- 🛠️ **Build Info**: Android `Build.*` properties (board, fingerprint, hardware, supported ABIs, system features, ...) and iOS device details (device name, model name, localized model, `uname()` info)
- 🤖 **Emulator/Simulator Detection**: `isPhysicalDevice` flag on both platforms
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
  device_info_app: ^1.1.0
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
  DeviceInfo? _deviceInfo;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    try {
      final deviceInfo = await DeviceInfoApp.getDeviceInfo();
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
            : SingleChildScrollView(
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
                    Text('Area Code: +${_deviceInfo!.areaCode}'),
                    Text('Language: ${_deviceInfo!.localeApp.languageCode}'),
                    const SizedBox(height: 16),
                    const Text('RAM & Disk:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('Physical RAM: ${_deviceInfo!.physicalRamSize} MB'),
                    Text('Available RAM: ${_deviceInfo!.availableRamSize} MB'),
                    Text('Is Low RAM Device: ${_deviceInfo!.isLowRamDevice}'),
                    Text('Free Disk: ${_deviceInfo!.freeDiskSize} MB'),
                    Text('Total Disk: ${_deviceInfo!.totalDiskSize} MB'),
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
Future<void> getDeviceInfoSafely() async {
  try {
    final deviceInfo = await DeviceInfoApp.getDeviceInfo();

    // Access detailed locale information
    final locale = deviceInfo.localeApp;
    print('Language: ${locale.languageCode}');
    print('Country: ${locale.countryCode}');
    print('Area code: +${deviceInfo.areaCode}');

    // Check device capability
    if (deviceInfo.isLowRamDevice) {
      print('Warning: running on a low-RAM device, consider reducing memory usage.');
    }
    if (!deviceInfo.isPhysicalDevice) {
      print('Running on an emulator/simulator.');
    }

    // Native build info (Android-specific fields are empty on iOS and vice versa)
    print('Model: ${deviceInfo.model} (${deviceInfo.modelName})');
    print('System: ${deviceInfo.systemName} ${deviceInfo.systemVersion}');
    print('Kernel: ${deviceInfo.utsname.sysname} ${deviceInfo.utsname.release}');
  } on PlatformException catch (e) {
    print('Platform error: ${e.message}');
  } catch (e) {
    print('Unexpected error: $e');
  }
}
```

## 📚 API Reference

### DeviceInfoApp

The main class for accessing device information.

#### Methods

##### `getDeviceInfo()`

Returns a `Future<DeviceInfo?>` containing comprehensive device and app information. The result is cached after the first successful call.

**Returns:**
- `Future<DeviceInfo?>` - Device and app information

**Throws:**
- `PlatformException` - If the platform doesn't support the operation

### DeviceInfo Model

The data model containing all device and app information.

#### App & locale properties

| Property | Type | Description |
|----------|------|-------------|
| `versionNumber` | `String` | Application version number |
| `buildNumber` | `String` | Application build number |
| `displayName` | `String` | Application display name |
| `bundleName` | `String` | Application bundle identifier |
| `uuid` | `String` | Device unique identifier |
| `locales` | `String` | Device locale information |
| `timeZone` | `String` | Device timezone |
| `alphaCode` | `String` | Country alpha code from device locale (e.g. "VN") |
| `areaCode` | `String` | International dial code derived from `alphaCode` (e.g. "84"). Computed, always in sync with `alphaCode` |
| `localeApp` | `LocaleApp` | Detailed locale information |

#### RAM & disk properties

| Property | Type | Description |
|----------|------|-------------|
| `isLowRamDevice` | `bool` | Whether the OS considers this a low-RAM device |
| `physicalRamSize` | `int` | Total physical RAM in MB |
| `availableRamSize` | `int` | Currently available RAM in MB |
| `totalRam` | `int` | RAM bucketed to 2, 4, or 6 (GB) |
| `freeDiskSize` | `int` | Free internal storage in MB |
| `totalDiskSize` | `int` | Total internal storage in MB |

#### Shared device/build properties

| Property | Type | Description |
|----------|------|-------------|
| `brand` | `String` | Device brand |
| `manufacturer` | `String` | Device manufacturer |
| `model` | `String` | Device model. **Differs per platform**: specific hardware model on Android (e.g. "SM-G991B"), generic device type on iOS (e.g. "iPhone"). Use `modelName` for the specific iOS hardware identifier |
| `systemName` | `String` | OS name (e.g. "Android", "iOS") |
| `systemVersion` | `String` | OS version |
| `isPhysicalDevice` | `bool` | `false` if running on an emulator/simulator |
| `utsname` | `Utsname` | POSIX `uname()` info: `sysname`, `nodename`, `release`, `version`, `machine` |

#### Android-only properties (empty/default on iOS)

| Property | Type | Description |
|----------|------|-------------|
| `board` | `String` | `Build.BOARD` |
| `bootloader` | `String` | `Build.BOOTLOADER` |
| `device` | `String` | `Build.DEVICE` |
| `display` | `String` | `Build.DISPLAY` |
| `fingerprint` | `String` | `Build.FINGERPRINT` |
| `hardware` | `String` | `Build.HARDWARE` |
| `host` | `String` | `Build.HOST` |
| `buildId` | `String` | `Build.ID` |
| `product` | `String` | `Build.PRODUCT` |
| `supported32BitAbis` | `List<String>` | `Build.SUPPORTED_32_BIT_ABIS` |
| `supported64BitAbis` | `List<String>` | `Build.SUPPORTED_64_BIT_ABIS` |
| `supportedAbis` | `List<String>` | `Build.SUPPORTED_ABIS` |
| `tags` | `String` | `Build.TAGS` |
| `type` | `String` | `Build.TYPE` |
| `systemFeatures` | `List<String>` | Available system features (`PackageManager`) |

#### iOS-only properties (empty/default on Android)

| Property | Type | Description |
|----------|------|-------------|
| `deviceName` | `String` | `UIDevice.current.name` |
| `modelName` | `String` | Raw hardware identifier (e.g. "iPhone14,2") |
| `localizedModel` | `String` | `UIDevice.current.localizedModel` |
| `isiOSAppOnMac` | `bool` | Whether running as an iOS app on Mac |

### LocaleApp Model

Contains detailed locale information.

| Property | Type | Description |
|----------|------|-------------|
| `languageCode` | `String` | Language code (e.g., 'en', 'vi') |
| `countryCode` | `String` | Country code (e.g., 'US', 'VN') |

### Utsname Model

POSIX `uname()` info, populated on both Android and iOS.

| Property | Type | Description |
|----------|------|-------------|
| `sysname` | `String` | Kernel name |
| `nodename` | `String` | Network node hostname |
| `release` | `String` | Kernel release |
| `version` | `String` | Kernel version |
| `machine` | `String` | Hardware identifier |

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
