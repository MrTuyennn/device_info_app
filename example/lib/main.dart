import 'dart:async';

import 'package:device_info_app/device_info_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DeviceInfo? _deviceInfo;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    try {
      final deviceInfo = await DeviceInfoApp.getDeviceInfo();
      setState(() {
        _deviceInfo = deviceInfo;
      });
      print(_deviceInfo.toString());
      print('----> ${_deviceInfo!.areaCode}');
    } catch (e) {
      print('Error getting device info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Device Info')),
        body: _deviceInfo == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('App Version: ${_deviceInfo!.versionNumber}'),
                    Text('Build Number: ${_deviceInfo!.buildNumber}'),
                    Text('App Name: ${_deviceInfo!.displayName}'),
                    Text('Bundle ID: ${_deviceInfo!.bundleName}'),
                    Text('Device UUID: ${_deviceInfo!.uuid}'),
                    Text('Locales: ${_deviceInfo!.locales}'),
                    Text('Time Zone: ${_deviceInfo!.timeZone}'),
                    Text('Country Code: ${_deviceInfo!.alphaCode}'),
                    Text('Area Code: +${_deviceInfo!.areaCode}'),
                    Text('Language: ${_deviceInfo!.localeApp.languageCode}'),
                    Text('availableRamSize: ${_deviceInfo!.availableRamSize}'),
                    Text('physicalRamSize: ${_deviceInfo!.physicalRamSize}'),
                    Text('isLowRamDevice: ${_deviceInfo!.isLowRamDevice}'),
                    Text('totalRam: ${_deviceInfo!.totalRam}'),
                    Divider(),
                    Text('Brand: ${_deviceInfo!.brand}'),
                    Text('Manufacturer: ${_deviceInfo!.manufacturer}'),
                    Text('Model: ${_deviceInfo!.model}'),
                    Text('System Name: ${_deviceInfo!.systemName}'),
                    Text('System Version: ${_deviceInfo!.systemVersion}'),
                    Text('Is Physical Device: ${_deviceInfo!.isPhysicalDevice}'),
                    Text('Free Disk Size (MB): ${_deviceInfo!.freeDiskSize}'),
                    Text('Total Disk Size (MB): ${_deviceInfo!.totalDiskSize}'),
                    Text(
                      'Utsname: ${_deviceInfo!.utsname.sysname} ${_deviceInfo!.utsname.release} (${_deviceInfo!.utsname.machine})',
                    ),
                    Divider(),
                    Text('[Android] Board: ${_deviceInfo!.board}'),
                    Text('[Android] Bootloader: ${_deviceInfo!.bootloader}'),
                    Text('[Android] Device: ${_deviceInfo!.device}'),
                    Text('[Android] Display: ${_deviceInfo!.display}'),
                    Text('[Android] Fingerprint: ${_deviceInfo!.fingerprint}'),
                    Text('[Android] Hardware: ${_deviceInfo!.hardware}'),
                    Text('[Android] Host: ${_deviceInfo!.host}'),
                    Text('[Android] Build ID: ${_deviceInfo!.buildId}'),
                    Text('[Android] Product: ${_deviceInfo!.product}'),
                    Text('[Android] Tags: ${_deviceInfo!.tags}'),
                    Text('[Android] Type: ${_deviceInfo!.type}'),
                    Text(
                      '[Android] Supported ABIs: ${_deviceInfo!.supportedAbis.join(', ')}',
                    ),
                    Divider(),
                    Text('[iOS] Device Name: ${_deviceInfo!.deviceName}'),
                    Text('[iOS] Model Name: ${_deviceInfo!.modelName}'),
                    Text(
                      '[iOS] Localized Model: ${_deviceInfo!.localizedModel}',
                    ),
                    Text('[iOS] Is iOS App On Mac: ${_deviceInfo!.isiOSAppOnMac}'),
                  ],
                ),
              ),
      ),
    );
  }
}
