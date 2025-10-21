import Flutter
import UIKit

public class DeviceInfoAppPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "device_info_app", binaryMessenger: registrar.messenger())
    let instance = DeviceInfoAppPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getDeviceInfo":
        let appInfo = versionApp()
        let jsonAppInfo = appInfo.toJson()
        result(jsonAppInfo)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
