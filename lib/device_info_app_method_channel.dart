import 'package:device_info_app/model/device_info_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'device_info_app_platform_interface.dart';

/// An implementation of [DeviceInfoAppPlatform] that uses method channels.
class MethodChannelDeviceInfoApp extends DeviceInfoAppPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('device_info_app');

  @override
  Future<DeviceInfo> getDeviceInfo() async {
    Map<dynamic, dynamic> appInfo = await methodChannel.invokeMethod(
      'getDeviceInfo',
    );
    return DeviceInfo.fromJson(appInfo);
  }
}
