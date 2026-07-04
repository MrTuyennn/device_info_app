import 'package:flutter_test/flutter_test.dart';
import 'package:device_info_app/device_info_app.dart';
import 'package:device_info_app/device_info_app_platform_interface.dart';
import 'package:device_info_app/device_info_app_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDeviceInfoAppPlatform
    with MockPlatformInterfaceMixin
    implements DeviceInfoAppPlatform {
  @override
  Future<DeviceInfo> getDeviceInfo() => Future.value(
        DeviceInfo(
          versionNumber: '2.0.0',
          buildNumber: '7',
          displayName: 'Mock App',
          bundleName: 'com.example.mock',
          alphaCode: 'KR',
        ),
      );
}

void main() {
  final DeviceInfoAppPlatform initialPlatform = DeviceInfoAppPlatform.instance;

  test('$MethodChannelDeviceInfoApp is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDeviceInfoApp>());
  });

  test('getDeviceInfo', () async {
    MockDeviceInfoAppPlatform fakePlatform = MockDeviceInfoAppPlatform();
    DeviceInfoAppPlatform.instance = fakePlatform;

    final deviceInfo = await DeviceInfoApp.getDeviceInfo();
    expect(deviceInfo?.versionNumber, '2.0.0');
    expect(deviceInfo?.bundleName, 'com.example.mock');
    expect(deviceInfo?.alphaCode, 'KR');
    expect(deviceInfo?.areaCode, '82');
  });
}
