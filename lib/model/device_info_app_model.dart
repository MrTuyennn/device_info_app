import 'dart:math';

import '../utils/country_dial_codes.dart';

class DeviceInfo {
  final String versionNumber;
  final String buildNumber;
  final String displayName;
  final String bundleName;
  final String uuid;
  final String locales;
  final String timeZone;
  final String alphaCode;
  final LocaleApp localeApp;
  final bool isLowRamDevice;
  final int physicalRamSize;
  final int availableRamSize;
  final int totalRam;

  // Android-only build info (empty/default on iOS).
  final String board;
  final String bootloader;
  final String device;
  final String display;
  final String fingerprint;
  final String hardware;
  final String host;
  final String buildId;
  final String product;
  final List<String> supported32BitAbis;
  final List<String> supported64BitAbis;
  final List<String> supportedAbis;
  final String tags;
  final String type;
  final List<String> systemFeatures;

  // iOS-only device info (empty/default on Android).
  final String deviceName;
  final String modelName;
  final String localizedModel;
  final bool isiOSAppOnMac;

  // Shared across both platforms.
  final String brand;
  final String manufacturer;

  /// Device model. **Not equivalent across platforms**: on Android this is
  /// the specific hardware model (`Build.MODEL`, e.g. "SM-G991B"); on iOS
  /// this is only the generic device type (`UIDevice.current.model`, e.g.
  /// "iPhone" or "iPad"). For the specific iOS hardware identifier
  /// (e.g. "iPhone14,2"), use [modelName] instead.
  final String model;
  final String systemName;
  final String systemVersion;
  final bool isPhysicalDevice;
  final int freeDiskSize;
  final int totalDiskSize;
  final Utsname utsname;

  /// International dial code derived from [alphaCode] (e.g. "VN" -> "84").
  /// Computed on read so it can never diverge from [alphaCode].
  String get areaCode => dialCodeForCountry(alphaCode);

  DeviceInfo({
    this.versionNumber = '',
    this.buildNumber = '',
    this.displayName = '',
    this.bundleName = '',
    this.uuid = '',
    this.locales = '',
    this.timeZone = '',
    this.alphaCode = '',
    this.localeApp = const LocaleApp(),
    this.isLowRamDevice = false,
    this.physicalRamSize = 0,
    this.availableRamSize = 0,
    this.totalRam = 0,
    this.board = '',
    this.bootloader = '',
    this.device = '',
    this.display = '',
    this.fingerprint = '',
    this.hardware = '',
    this.host = '',
    this.buildId = '',
    this.product = '',
    this.supported32BitAbis = const [],
    this.supported64BitAbis = const [],
    this.supportedAbis = const [],
    this.tags = '',
    this.type = '',
    this.systemFeatures = const [],
    this.deviceName = '',
    this.modelName = '',
    this.localizedModel = '',
    this.isiOSAppOnMac = false,
    this.brand = '',
    this.manufacturer = '',
    this.model = '',
    this.systemName = '',
    this.systemVersion = '',
    this.isPhysicalDevice = true,
    this.freeDiskSize = 0,
    this.totalDiskSize = 0,
    this.utsname = const Utsname(),
  });

  DeviceInfo.fromJson(Map<dynamic, dynamic> json)
    : versionNumber = json["versionNumber"] ?? '',
      buildNumber = json["buildNumber"] ?? '',
      displayName = json["displayName"] ?? '',
      bundleName = json["bundleName"] ?? '',
      uuid = json["uuid"] ?? '',
      locales = json["locales"] ?? '',
      timeZone = json["timeZone"] ?? '',
      alphaCode = json["alphaCode"] ?? '',
      localeApp = LocaleApp.fromJson(json["locale"] ?? {}),
      isLowRamDevice = json["isLowRamDevice"] ?? false,
      physicalRamSize = json["physicalRamSize"] ?? 0,
      availableRamSize = json["availableRamSize"] ?? 0,
      totalRam = totalRamDevice(json["physicalRamSize"] ?? 0),
      board = json["board"] ?? '',
      bootloader = json["bootloader"] ?? '',
      device = json["device"] ?? '',
      display = json["display"] ?? '',
      fingerprint = json["fingerprint"] ?? '',
      hardware = json["hardware"] ?? '',
      host = json["host"] ?? '',
      buildId = json["buildId"] ?? '',
      product = json["product"] ?? '',
      supported32BitAbis = List<String>.from(json["supported32BitAbis"] ?? []),
      supported64BitAbis = List<String>.from(json["supported64BitAbis"] ?? []),
      supportedAbis = List<String>.from(json["supportedAbis"] ?? []),
      tags = json["tags"] ?? '',
      type = json["type"] ?? '',
      systemFeatures = List<String>.from(json["systemFeatures"] ?? []),
      deviceName = json["deviceName"] ?? '',
      modelName = json["modelName"] ?? '',
      localizedModel = json["localizedModel"] ?? '',
      isiOSAppOnMac = json["isiOSAppOnMac"] ?? false,
      brand = json["brand"] ?? '',
      manufacturer = json["manufacturer"] ?? '',
      model = json["model"] ?? '',
      systemName = json["systemName"] ?? '',
      systemVersion = json["systemVersion"] ?? '',
      isPhysicalDevice = json["isPhysicalDevice"] ?? true,
      freeDiskSize = json["freeDiskSize"] ?? 0,
      totalDiskSize = json["totalDiskSize"] ?? 0,
      utsname = Utsname.fromJson(json["utsname"] ?? {});

  Map<String, dynamic> toJson() => {
    "versionNumber": versionNumber,
    "buildNumber": buildNumber,
    "displayName": displayName,
    "bundleName": bundleName,
    "uuid": uuid,
    "locales": locales,
    "timeZone": timeZone,
    "alphaCode": alphaCode,
    "areaCode": areaCode,
    "locale": {
      "languageCode": localeApp.languageCode,
      "countryCode": localeApp.countryCode,
    },
    "isLowRamDevice": isLowRamDevice,
    "physicalRamSize": physicalRamSize,
    "availableRamSize": availableRamSize,
    "totalRam": totalRam,
    "board": board,
    "bootloader": bootloader,
    "device": device,
    "display": display,
    "fingerprint": fingerprint,
    "hardware": hardware,
    "host": host,
    "buildId": buildId,
    "product": product,
    "supported32BitAbis": supported32BitAbis,
    "supported64BitAbis": supported64BitAbis,
    "supportedAbis": supportedAbis,
    "tags": tags,
    "type": type,
    "systemFeatures": systemFeatures,
    "deviceName": deviceName,
    "modelName": modelName,
    "localizedModel": localizedModel,
    "isiOSAppOnMac": isiOSAppOnMac,
    "brand": brand,
    "manufacturer": manufacturer,
    "model": model,
    "systemName": systemName,
    "systemVersion": systemVersion,
    "isPhysicalDevice": isPhysicalDevice,
    "freeDiskSize": freeDiskSize,
    "totalDiskSize": totalDiskSize,
    "utsname": utsname.toJson(),
  };
}

class LocaleApp {
  final String languageCode;
  final String countryCode;

  const LocaleApp({this.languageCode = '', this.countryCode = ''});

  LocaleApp.fromJson(Map<dynamic, dynamic> json)
    : languageCode = json["languageCode"] ?? '',
      countryCode = json["countryCode"] ?? '';
}

/// POSIX `uname()` info. Populated on both Android and iOS since both run
/// on top of a kernel that exposes this via the `uname` syscall.
class Utsname {
  final String sysname;
  final String nodename;
  final String release;
  final String version;
  final String machine;

  const Utsname({
    this.sysname = '',
    this.nodename = '',
    this.release = '',
    this.version = '',
    this.machine = '',
  });

  Utsname.fromJson(Map<dynamic, dynamic> json)
    : sysname = json["sysname"] ?? '',
      nodename = json["nodename"] ?? '',
      release = json["release"] ?? '',
      version = json["version"] ?? '',
      machine = json["machine"] ?? '';

  Map<String, dynamic> toJson() => {
    "sysname": sysname,
    "nodename": nodename,
    "release": release,
    "version": version,
    "machine": machine,
  };
}

int totalRamDevice(int physicalRamSize) =>
    roundDouble(physicalRamSize / 1024, 1);

int roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  final totalRamInGB = ((value * mod).round().toDouble() / mod);
  if (totalRamInGB >= 7) {
    return 6;
  } else if (totalRamInGB >= 5) {
    return 4;
  } else {
    return 2;
  }
}
