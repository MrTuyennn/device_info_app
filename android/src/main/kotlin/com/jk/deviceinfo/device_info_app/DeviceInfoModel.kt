package com.jk.deviceinfo.device_info_app

class AppInfo {
    var versionNumber : String = ""
    var buildNumber: String = ""
    var displayName: String = ""
    var bundleName: String = ""
    var uuid: String =""
    var locales: String = ""
    var alphaCode: String = ""
    var timeZone: String = ""
    var locale: LocaleApp = LocaleApp("","")

    var isLowRamDevice: Boolean = false
    var physicalRamSize: Int = 0
    var availableRamSize: Int = 0

    // Android build info (android.os.Build).
    var board: String = ""
    var bootloader: String = ""
    var brand: String = ""
    var device: String = ""
    var display: String = ""
    var fingerprint: String = ""
    var hardware: String = ""
    var host: String = ""
    var buildId: String = ""
    var manufacturer: String = ""
    var model: String = ""
    var product: String = ""
    var supported32BitAbis: List<String> = emptyList()
    var supported64BitAbis: List<String> = emptyList()
    var supportedAbis: List<String> = emptyList()
    var tags: String = ""
    var type: String = ""
    var systemFeatures: List<String> = emptyList()

    var systemName: String = "Android"
    var systemVersion: String = ""
    var isPhysicalDevice: Boolean = true
    var freeDiskSize: Int = 0
    var totalDiskSize: Int = 0
    var utsname: Utsname = Utsname()

    fun toJson(): Map<String, Any> {
        return mapOf(
            "versionNumber" to versionNumber,
            "buildNumber" to buildNumber,
            "displayName" to displayName,
            "bundleName" to bundleName,
            "uuid" to uuid,
            "locales" to locales,
            "timeZone" to timeZone,
            "alphaCode" to alphaCode,
            "locale" to locale.toJson(),
            "isLowRamDevice" to isLowRamDevice,
            "physicalRamSize" to physicalRamSize,
            "availableRamSize" to availableRamSize,
            "board" to board,
            "bootloader" to bootloader,
            "brand" to brand,
            "device" to device,
            "display" to display,
            "fingerprint" to fingerprint,
            "hardware" to hardware,
            "host" to host,
            "buildId" to buildId,
            "manufacturer" to manufacturer,
            "model" to model,
            "product" to product,
            "supported32BitAbis" to supported32BitAbis,
            "supported64BitAbis" to supported64BitAbis,
            "supportedAbis" to supportedAbis,
            "tags" to tags,
            "type" to type,
            "systemFeatures" to systemFeatures,
            "systemName" to systemName,
            "systemVersion" to systemVersion,
            "isPhysicalDevice" to isPhysicalDevice,
            "freeDiskSize" to freeDiskSize,
            "totalDiskSize" to totalDiskSize,
            "utsname" to utsname.toJson()
        )
    }
}


class LocaleApp(val languageCode: String, val countryCode:String) {
    fun toJson(): Map<String, Any> {
        return mapOf(
            "languageCode" to languageCode,
            "countryCode" to countryCode,)
    }
}

class Utsname(
    val sysname: String = "",
    val nodename: String = "",
    val release: String = "",
    val version: String = "",
    val machine: String = ""
) {
    fun toJson(): Map<String, Any> {
        return mapOf(
            "sysname" to sysname,
            "nodename" to nodename,
            "release" to release,
            "version" to version,
            "machine" to machine
        )
    }
}
