package com.jk.deviceinfo.device_info_app

import android.content.Context
import android.os.Build
import android.provider.Settings
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
            val packageManager = appContext.packageManager
            val info = packageManager.getPackageInfo(appContext.packageName, 0)
            val language = Locale.getDefault().language
            val diaCode = Locale.getDefault().country
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
            }
            result.success(infoApp.toJson())
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
