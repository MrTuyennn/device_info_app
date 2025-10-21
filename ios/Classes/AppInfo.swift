//
//  AppInfo.swift
//  
//
//  Created by Nguyen Ngoc Tuyen on 21/10/25.
//

import Foundation

struct AppInfo {
    let versionNumber : String
    let buildNumber: String
    let displayName: String
    let bundleName: String
    let uuid: String
    let locales: String
    let timeZone: String
    let locale: LocaleApp
    
    func toJson() -> [String: Any] {
            return [
                "versionNumber": versionNumber,
                "buildNumber": buildNumber,
                "displayName": displayName,
                "bundleName": bundleName,
                "uuid": uuid,
                "locales": locales,
                "timeZone":timeZone,
                "locale": locale.toJson()
            ]
        }
}



func versionApp() -> AppInfo {
    let dictionary = Bundle.main.infoDictionary!
    let versionNumber = dictionary[Constants.InfoPlist.versionNumber] as! String
    let buildNumber = dictionary[Constants.InfoPlist.buildNumber] as! String
    let displayName = dictionary[Constants.InfoPlist.displayName] as! String
    let bundleName = dictionary[Constants.InfoPlist.bundleName] as! String
    let uuid = UIDevice.current.identifierForVendor!.uuidString
    let locales = Bundle.main.preferredLocalizations
    let locale = locales.first ?? ""
    let timeZone = TimeZone.current.identifier
    
    let localeApp = Locale.current
    let languageCode: String?
    let countryCode: String?
    if #available(iOS 16, *) {
        languageCode =   Locale.current.language.languageCode?.identifier
        countryCode = Locale.current.region?.identifier
    } else {
        languageCode = localeApp.languageCode // Language code for the current locale
        countryCode = localeApp.regionCode // Country code for the current locale
    }
    
    
    return AppInfo(
        versionNumber: versionNumber,
        buildNumber: buildNumber,
        displayName: displayName,
        bundleName: bundleName,
        uuid: uuid,
        locales: locale,
        timeZone: timeZone,
        locale: LocaleApp(languageCode: languageCode ?? "en", countryCode: countryCode ?? "US")
    )
}


enum Constants {
    enum InfoPlist {
        static let versionNumber = "CFBundleShortVersionString"
        static let buildNumber = "CFBundleVersion"
        static let displayName = "CFBundleDisplayName"
        static let bundleName = "CFBundleIdentifier"
    }
}
