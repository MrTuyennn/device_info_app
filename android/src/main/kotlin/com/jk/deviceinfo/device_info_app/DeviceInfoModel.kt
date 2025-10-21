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
            "locale" to locale.toJson()
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