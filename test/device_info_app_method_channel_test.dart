import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:device_info_app/device_info_app_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelDeviceInfoApp platform = MethodChannelDeviceInfoApp();
  const MethodChannel channel = MethodChannel('device_info_app');

  final fakeDeviceInfo = <String, dynamic>{
    'versionNumber': '1.0.0',
    'buildNumber': '1',
    'displayName': 'Test App',
    'bundleName': 'com.example.test',
    'uuid': 'abc-123',
    'locales': 'vi',
    'timeZone': 'Asia/Ho_Chi_Minh',
    'alphaCode': 'VN',
    'locale': {'languageCode': 'vi', 'countryCode': 'VN'},
    'isLowRamDevice': false,
    'physicalRamSize': 4096,
    'availableRamSize': 2048,
    'board': 'goldfish_x86_64',
    'bootloader': 'unknown',
    'device': 'emu64a',
    'display': 'UPB2.230000',
    'fingerprint': 'google/sdk_gphone64_arm64/emu64a',
    'hardware': 'ranchu',
    'host': 'build-host',
    'buildId': 'UPB2.230000',
    'brand': 'google',
    'manufacturer': 'Google',
    'model': 'sdk_gphone64_arm64',
    'product': 'sdk_gphone64_arm64',
    'supported32BitAbis': ['armeabi-v7a'],
    'supported64BitAbis': ['arm64-v8a'],
    'supportedAbis': ['arm64-v8a', 'armeabi-v7a'],
    'tags': 'release-keys',
    'type': 'user',
    'systemFeatures': ['android.hardware.camera'],
    'systemName': 'Android',
    'systemVersion': '14',
    'isPhysicalDevice': false,
    'freeDiskSize': 10240,
    'totalDiskSize': 32768,
    'utsname': {
      'sysname': 'Linux',
      'nodename': 'localhost',
      'release': '5.10.0',
      'version': '#1 SMP',
      'machine': 'aarch64',
    },
  };

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'getDeviceInfo') {
        return fakeDeviceInfo;
      }
      return null;
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getDeviceInfo', () async {
    final result = await platform.getDeviceInfo();
    expect(result.versionNumber, '1.0.0');
    expect(result.buildNumber, '1');
    expect(result.bundleName, 'com.example.test');
    expect(result.alphaCode, 'VN');
    expect(result.areaCode, '84');
    expect(result.localeApp.languageCode, 'vi');

    expect(result.board, 'goldfish_x86_64');
    expect(result.bootloader, 'unknown');
    expect(result.device, 'emu64a');
    expect(result.display, 'UPB2.230000');
    expect(result.fingerprint, 'google/sdk_gphone64_arm64/emu64a');
    expect(result.hardware, 'ranchu');
    expect(result.host, 'build-host');
    expect(result.buildId, 'UPB2.230000');
    expect(result.brand, 'google');
    expect(result.manufacturer, 'Google');
    expect(result.model, 'sdk_gphone64_arm64');
    expect(result.product, 'sdk_gphone64_arm64');
    expect(result.supported32BitAbis, ['armeabi-v7a']);
    expect(result.supported64BitAbis, ['arm64-v8a']);
    expect(result.supportedAbis, ['arm64-v8a', 'armeabi-v7a']);
    expect(result.tags, 'release-keys');
    expect(result.type, 'user');
    expect(result.systemFeatures, ['android.hardware.camera']);
    expect(result.systemName, 'Android');
    expect(result.systemVersion, '14');
    expect(result.isPhysicalDevice, false);
    expect(result.freeDiskSize, 10240);
    expect(result.totalDiskSize, 32768);
    expect(result.utsname.sysname, 'Linux');
    expect(result.utsname.machine, 'aarch64');
  });
}
