## 1.1.1

### 📚 Documentation

- Added dartdoc comments across the public API (`DeviceInfoApp`, the platform interface/method channel classes, and every field of `DeviceInfo`, `LocaleApp`, and `Utsname`) to raise pub.dev documentation coverage.

## 1.1.0

### ✨ New features

- Added `areaCode` — international dial code derived from `alphaCode` (e.g. "VN" -> "84"), computed on read so it always stays in sync.
- Added ~25 new native device/build fields to `DeviceInfo`:
  - Android (`android.os.Build`): `board`, `bootloader`, `device`, `display`, `fingerprint`, `hardware`, `host`, `buildId`, `product`, `supported32BitAbis`, `supported64BitAbis`, `supportedAbis`, `tags`, `type`, `systemFeatures`.
  - iOS: `deviceName`, `modelName`, `localizedModel`, `isiOSAppOnMac`.
  - Shared: `brand`, `manufacturer`, `model`, `systemName`, `systemVersion`, `isPhysicalDevice`, `freeDiskSize`, `totalDiskSize`, `utsname` (POSIX `uname()` info: `sysname`/`nodename`/`release`/`version`/`machine`).

### 🐛 Bug fixes

- Fixed a potential crash on Android when `PackageManager.getSystemAvailableFeatures()` returns `null`.
- Fixed iOS `alphaCode` incorrectly defaulting to `"US"` (and therefore `areaCode` to `"1"`) on devices with no region set; now defaults to an empty string like Android.
- Improved Android emulator detection (`isPhysicalDevice`) to also recognize `goldfish`/`ranchu` hardware profiles used by modern Android Studio emulators.
- Documented that the shared `model` field differs in meaning across platforms (specific hardware model on Android vs. generic device type on iOS); use `modelName` for the specific iOS hardware identifier.
- `dialCodeForCountry` no longer coincidentally matches non-ISO region codes (e.g. UN M.49 numeric codes like "419").

### ⚡ Performance

- iOS: consolidated the `uname()` syscall and disk free/total size lookups to run once per `getDeviceInfo()` call instead of twice.

## 1.0.4

- add toJson Device Info

## 1.0.3

- fix some bug

## 1.0.2

- fix some bug

## 1.0.1

### 🚀 New Features & Improvements

#### ✨ RAM Information Support

- **Device RAM Details**: Get comprehensive RAM information including total memory, available memory, and memory usage statistics
- **Memory Monitoring**: Real-time memory usage tracking for better app performance optimization
- **Cross-Platform RAM Data**: Consistent RAM information across Android and iOS platforms

#### 📱 Enhanced Device Information

- Added `totalRam` - Total device RAM in bytes
- Added `availableRam` - Currently available RAM in bytes
- Added `usedRam` - Currently used RAM in bytes
- Added `ramUsagePercentage` - RAM usage as percentage (0-100)
- Added `ramInfo` - Detailed RAM information object

#### 🔧 API Updates

- Enhanced `getDeviceInfo()` method now returns RAM information
- Updated `DeviceInfo` model with new RAM properties
- Improved error handling for memory-related operations

#### 🐛 Bug Fixes

- Fixed potential null pointer exceptions in device info retrieval
- Improved memory allocation handling in native implementations
- Enhanced error messages for better debugging

---

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

- Initial development version
