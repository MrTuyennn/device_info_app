import 'package:device_info_app/model/device_info_app.dart';

import 'device_info_app_platform_interface.dart';
export './model/device_info_app.dart';

class DeviceInfoApp {
  Future<DeviceInfo> getDeviceInfo() {
    return DeviceInfoAppPlatform.instance.getDeviceInfo();
  }
}
