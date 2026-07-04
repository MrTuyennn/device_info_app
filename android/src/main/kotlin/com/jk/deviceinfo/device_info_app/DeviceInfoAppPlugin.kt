package com.jk.deviceinfo.device_info_app

import android.app.ActivityManager
import android.content.Context
import android.os.Build
import android.os.Environment
import android.os.StatFs
import android.provider.Settings
import android.system.Os
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.Locale
import java.util.TimeZone
import java.util.UUID

/** DeviceInfoAppPlugin */
class DeviceInfoAppPlugin :
    FlutterPlugin,
    MethodCallHandler {
    // The MethodChannel that will the communication between Flutter and native Android
    //
    // This local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var appContext: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        appContext = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "device_info_app")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result
    ) {
       if (call.method == "getDeviceInfo"){
           val activityManager: ActivityManager =
               appContext.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            val packageManager = appContext.packageManager
            val info = packageManager.getPackageInfo(appContext.packageName, 0)
            val language = Locale.getDefault().language
            val diaCode = Locale.getDefault().country
           val memoryInfo: ActivityManager.MemoryInfo = ActivityManager.MemoryInfo()
             activityManager.getMemoryInfo(memoryInfo)
            val infoApp = AppInfo().apply {
                displayName = info.applicationInfo?.loadLabel(packageManager).toString()
                bundleName = appContext.packageName
                versionNumber = info.versionName.toString()
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                    buildNumber = info.longVersionCode.toString()
                }
                val id = Settings.Secure.getString(appContext.contentResolver, Settings.Secure.ANDROID_ID);
                uuid = UUID.nameUUIDFromBytes(id.toByteArray()).toString()
                locales = language.toString()
                timeZone = TimeZone.getDefault().id.toString();
                alphaCode = diaCode
                locale = LocaleApp(language.toString(),diaCode.toString())
                isLowRamDevice = memoryInfo.lowMemory
                physicalRamSize = (memoryInfo.totalMem / 1048576L).toInt()
                availableRamSize = (memoryInfo.availMem / 1048576L).toInt()

                board = Build.BOARD
                bootloader = Build.BOOTLOADER
                brand = Build.BRAND
                device = Build.DEVICE
                display = Build.DISPLAY
                fingerprint = Build.FINGERPRINT
                hardware = Build.HARDWARE
                host = Build.HOST
                buildId = Build.ID
                manufacturer = Build.MANUFACTURER
                model = Build.MODEL
                product = Build.PRODUCT
                supported32BitAbis = Build.SUPPORTED_32_BIT_ABIS.toList()
                supported64BitAbis = Build.SUPPORTED_64_BIT_ABIS.toList()
                supportedAbis = Build.SUPPORTED_ABIS.toList()
                tags = Build.TAGS
                type = Build.TYPE
                systemFeatures = (packageManager.systemAvailableFeatures ?: emptyArray())
                    .mapNotNull { it.name }
                systemVersion = Build.VERSION.RELEASE
                isPhysicalDevice = isPhysicalAndroidDevice()

                val dataDirStat = StatFs(Environment.getDataDirectory().path)
                freeDiskSize = (dataDirStat.availableBytes / 1048576L).toInt()
                totalDiskSize = (dataDirStat.totalBytes / 1048576L).toInt()

                utsname = try {
                    val uts = Os.uname()
                    Utsname(uts.sysname, uts.nodename, uts.release, uts.version, uts.machine)
                } catch (e: Exception) {
                    Log.w("DeviceInfoAppPlugin", "Os.uname() failed, returning empty Utsname", e)
                    Utsname()
                }
            }
            result.success(infoApp.toJson())
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun isPhysicalAndroidDevice(): Boolean {
        return !(Build.FINGERPRINT.startsWith("generic")
            || Build.FINGERPRINT.startsWith("unknown")
            || Build.MODEL.contains("google_sdk")
            || Build.MODEL.contains("Emulator")
            || Build.MODEL.contains("Android SDK built for x86")
            || Build.MODEL.contains("sdk_gphone")
            || Build.MANUFACTURER.contains("Genymotion")
            || (Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic"))
            || Build.PRODUCT == "google_sdk"
            || Build.PRODUCT.contains("sdk_gphone")
            // goldfish/ranchu is the emulator hardware profile used by every
            // official Android emulator image (including current
            // "sdk_gphone*" Android Studio emulators), regardless of the
            // FINGERPRINT/MODEL/PRODUCT strings above, which OEM emulator
            // vendors are free to customize.
            || Build.HARDWARE.contains("goldfish")
            || Build.HARDWARE.contains("ranchu"))
    }
}
