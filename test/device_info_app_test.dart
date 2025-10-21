import 'package:flutter_test/flutter_test.dart';
import 'package:device_info_app/device_info_app.dart';
import 'package:device_info_app/device_info_app_platform_interface.dart';
import 'package:device_info_app/device_info_app_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceInfoAppPlatform
    with MockPlatformInterfaceMixin
    implements DeviceInfoAppPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DeviceInfoAppPlatform initialPlatform = DeviceInfoAppPlatform.instance;

  test('$MethodChannelDeviceInfoApp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeviceInfoApp>());
  });

  test('getPlatformVersion', () async {
    DeviceInfoApp deviceInfoAppPlugin = DeviceInfoApp();
    MockDeviceInfoAppPlatform fakePlatform = MockDeviceInfoAppPlatform();
    DeviceInfoAppPlatform.instance = fakePlatform;

    expect(await deviceInfoAppPlugin.getPlatformVersion(), '42');
  });
}
