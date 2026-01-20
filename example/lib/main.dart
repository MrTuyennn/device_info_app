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
            : Padding(
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
                    Text('Language: ${_deviceInfo!.localeApp.languageCode}'),
                    Text('availableRamSize: ${_deviceInfo!.availableRamSize}'),
                    Text('physicalRamSize: ${_deviceInfo!.physicalRamSize}'),
                    Text('isLowRamDevice: ${_deviceInfo!.isLowRamDevice}'),
                    Text('totalRam: ${_deviceInfo!.totalRam}'),
                  ],
                ),
              ),
      ),
    );
  }
}
