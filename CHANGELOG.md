## 1.0.0

### 🎉 Initial Release

**Device Info App** - A comprehensive Flutter plugin for retrieving detailed device and application information across Android and iOS platforms.

#### ✨ Features

- **Device Information**: Get comprehensive device details including model, brand, platform version
- **App Information**: Retrieve application-specific data like version, build number, bundle identifier
- **Localization Support**: Access device locale and timezone information
- **Cross-Platform**: Full support for both Android and iOS
- **Type-Safe**: Strongly typed Dart models for all returned data
- **Null Safety**: Full null safety support for robust error handling

#### 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (iOS 11.0+)

#### 🔧 API Methods

- `getDeviceInfo()` - Returns comprehensive device and app information
- Returns `DeviceInfo` model with the following properties:
  - `versionNumber` - App version number
  - `buildNumber` - App build number  
  - `displayName` - App display name
  - `bundleName` - App bundle identifier
  - `uuid` - Device unique identifier
  - `locales` - Device locale information
  - `timeZone` - Device timezone
  - `alphaCode` - Country alpha code
  - `localeApp` - Detailed locale information (language and country codes)

#### 🚀 Getting Started

```dart
import 'package:device_info_app/device_info_app.dart';

final deviceInfoApp = DeviceInfoApp();
final deviceInfo = await deviceInfoApp.getDeviceInfo();

print('App Version: ${deviceInfo.versionNumber}');
print('Device Model: ${deviceInfo.displayName}');
print('Platform: ${deviceInfo.locales}');
```

#### 🏗️ Architecture

- **Platform Interface Pattern**: Clean separation between Flutter and native code
- **Method Channel Communication**: Efficient cross-platform communication
- **Modular Design**: Easy to extend and maintain
- **Error Handling**: Comprehensive error handling with fallback values

#### 📦 Dependencies

- Flutter SDK: ^3.3.0
- Dart SDK: ^3.9.2
- plugin_platform_interface: ^2.0.2

---

## 0.0.1

* Initial development version
