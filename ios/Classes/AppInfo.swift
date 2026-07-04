//
//  AppInfo.swift
//
//
//  Created by Nguyen Ngoc Tuyen on 21/10/25.
//

import Foundation
import UIKit
import MachO
import Darwin.Mach

struct AppInfo {
    let versionNumber : String
    let buildNumber: String
    let displayName: String
    let bundleName: String
    let uuid: String
    let locales: String
    let timeZone: String
    let alphaCode: String
    let locale: LocaleApp
    let physicalRamSize: Int
    let availableRamSize: Int

    // iOS-only device info (empty/default on Android).
    let deviceName: String
    /// Định danh phần cứng thô, ví dụ "iPhone14,2". Không tra bảng sang tên
    /// thương mại (ví dụ "iPhone 13 Pro") vì bảng đó rất lớn và thay đổi theo
    /// từng đời máy mới.
    let modelName: String
    let localizedModel: String
    let isiOSAppOnMac: Bool

    // Shared across both platforms.
    let brand: String
    let manufacturer: String
    let model: String
    let systemName: String
    let systemVersion: String
    let isPhysicalDevice: Bool
    let freeDiskSize: Int
    let totalDiskSize: Int
    let utsname: Utsname

    func toJson() -> [String: Any] {
            return [
                "versionNumber": versionNumber,
                "buildNumber": buildNumber,
                "displayName": displayName,
                "bundleName": bundleName,
                "uuid": uuid,
                "locales": locales,
                "timeZone":timeZone,
                "alphaCode": alphaCode,
                "locale": locale.toJson(),
                "physicalRamSize": physicalRamSize,
                "availableRamSize": availableRamSize,
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
                "utsname": utsname.toJson()
            ]
        }
}

struct Utsname {
    let sysname: String
    let nodename: String
    let release: String
    let version: String
    let machine: String

    init(sysname: String = "", nodename: String = "", release: String = "", version: String = "", machine: String = "") {
        self.sysname = sysname
        self.nodename = nodename
        self.release = release
        self.version = version
        self.machine = machine
    }

    func toJson() -> [String: Any] {
        return [
            "sysname": sysname,
            "nodename": nodename,
            "release": release,
            "version": version,
            "machine": machine
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

    var isiOSAppOnMac = false
    if #available(iOS 14, *) {
        isiOSAppOnMac = ProcessInfo.processInfo.isiOSAppOnMac
    }

    let uts = currentUtsname()
    let diskSize = currentDiskSize()

    return AppInfo(
        versionNumber: versionNumber,
        buildNumber: buildNumber,
        displayName: displayName,
        bundleName: bundleName,
        uuid: uuid,
        locales: locale,
        timeZone: timeZone,
        alphaCode: countryCode ?? "",
        locale: LocaleApp(languageCode: languageCode ?? "en", countryCode: countryCode ?? "US"),
        physicalRamSize: physicalRamSizeInMB(),
        availableRamSize: availableMemoryInMB(),
        deviceName: UIDevice.current.name,
        modelName: uts.machine,
        localizedModel: UIDevice.current.localizedModel,
        isiOSAppOnMac: isiOSAppOnMac,
        brand: "Apple",
        manufacturer: "Apple",
        model: UIDevice.current.model,
        systemName: UIDevice.current.systemName,
        systemVersion: UIDevice.current.systemVersion,
        isPhysicalDevice: !isSimulator(),
        freeDiskSize: diskSize.free,
        totalDiskSize: diskSize.total,
        utsname: uts
    )
}

/// RAM khả dụng (MB) của thiết bị
func availableMemoryInMB() -> Int {
    var pageSize: vm_size_t = 0
    host_page_size(mach_host_self(), &pageSize)

    var stats = vm_statistics64()
    var count = mach_msg_type_number_t(MemoryLayout<vm_statistics64_data_t>.size / MemoryLayout<integer_t>.size)

    let result: kern_return_t = withUnsafeMutablePointer(to: &stats) { ptr in
        ptr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { intPtr in
            host_statistics64(mach_host_self(), HOST_VM_INFO64, intPtr, &count)
        }
    }

    guard result == KERN_SUCCESS else {
        return -1
    }

    let memFreeBytes = UInt64(stats.free_count) * UInt64(pageSize)
    return Int(memFreeBytes / 1_048_576) // 1024*1024
}

/// RAM vật lý (MB) của thiết bị
func physicalRamSizeInMB() -> Int {
    return Int(ProcessInfo.processInfo.physicalMemory / 1_048_576)
}

struct DiskSize {
    let free: Int
    let total: Int
}

/// Dung lượng trống/tổng (MB) của bộ nhớ trong, lấy từ một lần stat duy nhất.
func currentDiskSize() -> DiskSize {
    guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last,
          let attrs = try? FileManager.default.attributesOfFileSystem(forPath: path) else {
        return DiskSize(free: 0, total: 0)
    }
    let freeBytes = (attrs[.systemFreeSize] as? NSNumber)?.int64Value ?? 0
    let totalBytes = (attrs[.systemSize] as? NSNumber)?.int64Value ?? 0
    return DiskSize(free: Int(freeBytes / 1_048_576), total: Int(totalBytes / 1_048_576))
}

func currentUtsname() -> Utsname {
    var systemInfo = utsname()
    uname(&systemInfo)

    func toString<T>(_ value: T) -> String {
        var value = value
        return withUnsafePointer(to: &value) {
            $0.withMemoryRebound(to: CChar.self, capacity: MemoryLayout<T>.size) {
                String(cString: $0)
            }
        }
    }

    return Utsname(
        sysname: toString(systemInfo.sysname),
        nodename: toString(systemInfo.nodename),
        release: toString(systemInfo.release),
        version: toString(systemInfo.version),
        machine: toString(systemInfo.machine)
    )
}

func isSimulator() -> Bool {
    #if targetEnvironment(simulator)
    return true
    #else
    return false
    #endif
}

enum Constants {
    enum InfoPlist {
        static let versionNumber = "CFBundleShortVersionString"
        static let buildNumber = "CFBundleVersion"
        static let displayName = "CFBundleDisplayName"
        static let bundleName = "CFBundleIdentifier"
    }
}
