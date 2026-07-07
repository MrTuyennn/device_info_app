import 'dart:math';

import '../utils/country_dial_codes.dart';

/// Snapshot of device and app info collected from the native platform.
///
/// Populated via [DeviceInfo.fromJson] from the map returned by the native
/// method channel implementation. Fields that don't apply to the current
/// platform are left at their default value (empty string, `0`, or `false`).
class DeviceInfo {
  /// The app's version number (e.g. "1.0.0"), as declared in the app manifest.
  final String versionNumber;

  /// The app's build number (e.g. "42").
  final String buildNumber;

  /// The app's display name shown to the user.
  final String displayName;

  /// The app's bundle/package identifier.
  final String bundleName;

  /// A unique identifier for the device.
  final String uuid;

  /// The device's current locale identifier (e.g. "en_US").
  final String locales;

  /// The device's current time zone identifier (e.g. "Asia/Ho_Chi_Minh").
  final String timeZone;

  /// ISO 3166-1 alpha-2 country code derived from the device locale (e.g. "VN").
  final String alphaCode;

  /// The device's language and country locale, split into components.
  final LocaleApp localeApp;

  /// Whether the OS considers this device a low-RAM device.
  final bool isLowRamDevice;

  /// Total physical RAM size, in megabytes.
  final int physicalRamSize;

  /// Currently available RAM size, in megabytes.
  final int availableRamSize;

  /// Total RAM bucketed to the nearest marketed size (in GB): 2, 4, or 6.
  final int totalRam;

  // Android-only build info (empty/default on iOS).

  /// Android-only. The underlying board name.
  final String board;

  /// Android-only. The bootloader version.
  final String bootloader;

  /// Android-only. The industrial design name of the device.
  final String device;

  /// Android-only. A human-readable build display id.
  final String display;

  /// Android-only. A string that uniquely identifies this build.
  final String fingerprint;

  /// Android-only. The hardware name.
  final String hardware;

  /// Android-only. The host that built this build.
  final String host;

  /// Android-only. The changelist/build id.
  final String buildId;

  /// Android-only. The end-user visible name for the overall product.
  final String product;

  /// Android-only. Supported 32-bit ABIs.
  final List<String> supported32BitAbis;

  /// Android-only. Supported 64-bit ABIs.
  final List<String> supported64BitAbis;

  /// Android-only. All ABIs supported by the device, ordered by preference.
  final List<String> supportedAbis;

  /// Android-only. Comma-separated tags describing the build.
  final String tags;

  /// Android-only. The build type (e.g. "user", "eng").
  final String type;

  /// Android-only. System features reported by the device's package manager.
  final List<String> systemFeatures;

  // iOS-only device info (empty/default on Android).

  /// iOS-only. The user-assigned device name.
  final String deviceName;

  /// iOS-only. The specific hardware identifier (e.g. "iPhone14,2").
  final String modelName;

  /// iOS-only. The localized model name (e.g. "iPhone").
  final String localizedModel;

  /// iOS-only. Whether the app is running on a Mac via Mac Catalyst/iOS-on-Mac.
  final bool isiOSAppOnMac;

  // Shared across both platforms.

  /// The device brand.
  final String brand;

  /// The device manufacturer.
  final String manufacturer;

  /// Device model. **Not equivalent across platforms**: on Android this is
  /// the specific hardware model (`Build.MODEL`, e.g. "SM-G991B"); on iOS
  /// this is only the generic device type (`UIDevice.current.model`, e.g.
  /// "iPhone" or "iPad"). For the specific iOS hardware identifier
  /// (e.g. "iPhone14,2"), use [modelName] instead.
  final String model;

  /// The operating system name (e.g. "Android", "iOS").
  final String systemName;

  /// The operating system version (e.g. "14").
  final String systemVersion;

  /// Whether this is a physical device, as opposed to a simulator/emulator.
  final bool isPhysicalDevice;

  /// Free disk space, in bytes.
  final int freeDiskSize;

  /// Total disk space, in bytes.
  final int totalDiskSize;

  /// POSIX `uname()` info for the device.
  final Utsname utsname;

  /// International dial code derived from [alphaCode] (e.g. "VN" -> "84").
  /// Computed on read so it can never diverge from [alphaCode].
  String get areaCode => dialCodeForCountry(alphaCode);

  /// Creates a [DeviceInfo] with the given fields, defaulting to empty/zero
  /// values for anything not provided.
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

  /// Builds a [DeviceInfo] from the map returned by the native platform.
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

  /// Serializes this [DeviceInfo] to a JSON-compatible map.
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

/// The device's language and country locale, split into components.
class LocaleApp {
  /// ISO 639 language code (e.g. "en").
  final String languageCode;

  /// ISO 3166-1 alpha-2 country code (e.g. "US").
  final String countryCode;

  /// Creates a [LocaleApp], defaulting to empty codes.
  const LocaleApp({this.languageCode = '', this.countryCode = ''});

  /// Builds a [LocaleApp] from the map returned by the native platform.
  LocaleApp.fromJson(Map<dynamic, dynamic> json)
    : languageCode = json["languageCode"] ?? '',
      countryCode = json["countryCode"] ?? '';
}

/// POSIX `uname()` info. Populated on both Android and iOS since both run
/// on top of a kernel that exposes this via the `uname` syscall.
class Utsname {
  /// The operating system name.
  final String sysname;

  /// The network node hostname.
  final String nodename;

  /// The operating system release.
  final String release;

  /// The operating system version.
  final String version;

  /// The hardware identifier.
  final String machine;

  /// Creates a [Utsname], defaulting to empty values.
  const Utsname({
    this.sysname = '',
    this.nodename = '',
    this.release = '',
    this.version = '',
    this.machine = '',
  });

  /// Builds a [Utsname] from the map returned by the native platform.
  Utsname.fromJson(Map<dynamic, dynamic> json)
    : sysname = json["sysname"] ?? '',
      nodename = json["nodename"] ?? '',
      release = json["release"] ?? '',
      version = json["version"] ?? '',
      machine = json["machine"] ?? '';

  /// Serializes this [Utsname] to a JSON-compatible map.
  Map<String, dynamic> toJson() => {
    "sysname": sysname,
    "nodename": nodename,
    "release": release,
    "version": version,
    "machine": machine,
  };
}

/// Converts a physical RAM size in megabytes to a bucketed GB value
/// (2, 4, or 6) matching common marketed device RAM sizes.
int totalRamDevice(int physicalRamSize) =>
    roundDouble(physicalRamSize / 1024, 1);

/// Rounds [value] to [places] decimal places, then buckets the result to
/// the nearest marketed RAM size (2, 4, or 6 GB).
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
