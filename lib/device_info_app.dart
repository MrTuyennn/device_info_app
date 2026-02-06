import 'package:device_info_app/model/device_info_app_model.dart';

import 'device_info_app_platform_interface.dart';

export './model/device_info_app_model.dart';

class DeviceInfoApp {
  DeviceInfoApp._();

  static DeviceInfo? _deviceInfo;

  static Future<DeviceInfo?> getDeviceInfo() async {
    if (_deviceInfo == null) {
      final devicePackage = await DeviceInfoAppPlatform.instance
          .getDeviceInfo();
      _deviceInfo = devicePackage;
    }
    return _deviceInfo;
  }
}
