import 'dart:math';

class DeviceInfo {
  String versionNumber;
  String buildNumber;
  String displayName;
  String bundleName;
  String uuid;
  String locales;
  String timeZone;
  String alphaCode;
  LocaleApp localeApp;
  bool isLowRamDevice;
  int physicalRamSize;
  int availableRamSize;
  int totalRam;

  DeviceInfo({
    required this.versionNumber,
    required this.buildNumber,
    required this.displayName,
    required this.bundleName,
    required this.uuid,
    required this.locales,
    required this.timeZone,
    required this.alphaCode,
    required this.localeApp,
    required this.isLowRamDevice,
    required this.physicalRamSize,
    required this.availableRamSize,
    required this.totalRam,
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
      totalRam = totalRamDevice(json["physicalRamSize"] ?? 0);
}

class LocaleApp {
  String languageCode;
  String countryCode;

  LocaleApp({required this.languageCode, required this.countryCode});
  LocaleApp.fromJson(Map<dynamic, dynamic> json)
    : languageCode = json["languageCode"] ?? '',
      countryCode = json["countryCode"] ?? '';
}

int totalRamDevice(int physicalRamSize) => roundDouble(physicalRamSize / 1024, 1);

int roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  final totalRamInGB = ((value * mod).round().toDouble() / mod);
  if (totalRamInGB >= 7) {
    return 6; // Cao cấp
  } else if (totalRamInGB >= 5) {
    return 4; // Trung cấp
  } else {
    return 2; // Phổ thông
  }
}
