import 'package:device_info_app/model/device_info_app_model.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'device_info_app_method_channel.dart';

/// The interface that platform-specific implementations of this plugin must
/// implement.
///
/// Platform implementations should extend this class rather than implement
/// it as `DeviceInfoAppPlatform`, so new methods added here don't break
/// existing implementations.
abstract class DeviceInfoAppPlatform extends PlatformInterface {
  /// Constructs a DeviceInfoAppPlatform.
  DeviceInfoAppPlatform() : super(token: _token);

  static final Object _token = Object();

  static DeviceInfoAppPlatform _instance = MethodChannelDeviceInfoApp();

  /// The default instance of [DeviceInfoAppPlatform] to use.
  ///
  /// Defaults to [MethodChannelDeviceInfoApp].
  static DeviceInfoAppPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DeviceInfoAppPlatform] when
  /// they register themselves.
  static set instance(DeviceInfoAppPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Retrieves device and app information from the native platform.
  Future<DeviceInfo> getDeviceInfo() {
    throw UnimplementedError('getDeviceInfo() has not been implemented');
  }
}
