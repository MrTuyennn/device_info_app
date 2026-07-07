import 'package:device_info_app/model/device_info_app_model.dart';

import 'device_info_app_platform_interface.dart';

export './model/device_info_app_model.dart';

/// Entry point for retrieving device and app information.
class DeviceInfoApp {
  DeviceInfoApp._();

  static DeviceInfo? _deviceInfo;

  /// Returns the current device's [DeviceInfo], fetching it from the native
  /// platform on first call and caching the result for subsequent calls.
  static Future<DeviceInfo?> getDeviceInfo() async {
    if (_deviceInfo == null) {
      final devicePackage = await DeviceInfoAppPlatform.instance
          .getDeviceInfo();
      _deviceInfo = devicePackage;
    }
    return _deviceInfo;
  }
}
