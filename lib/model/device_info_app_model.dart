import 'dart:math';

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

  Map<String, dynamic> toJson() => {
    "versionNumber": versionNumber,
    "buildNumber": buildNumber,
    "displayName": displayName,
    "bundleName": bundleName,
    "uuid": uuid,
    "locales": locales,
    "timeZone": timeZone,
    "alphaCode": alphaCode,
    "locale": {
      "languageCode": localeApp.languageCode,
      "countryCode": localeApp.countryCode,
    },
    "isLowRamDevice": isLowRamDevice,
    "physicalRamSize": physicalRamSize,
    "availableRamSize": availableRamSize,
    "totalRam": totalRam,
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
