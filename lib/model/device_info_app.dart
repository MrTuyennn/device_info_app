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
      localeApp = LocaleApp.fromJson(json["locale"] ?? {});
}

class LocaleApp {
  String languageCode;
  String countryCode;

  LocaleApp({required this.languageCode, required this.countryCode});
  LocaleApp.fromJson(Map<dynamic, dynamic> json)
    : languageCode = json["languageCode"] ?? '',
      countryCode = json["countryCode"] ?? '';
}
