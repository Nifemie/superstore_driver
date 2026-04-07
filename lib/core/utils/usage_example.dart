// USAGE EXAMPLES FOR DeviceUtils AND PlatformResponsive

import 'package:flutter/material.dart';
import 'device_utils.dart';
import 'platform_responsive.dart';

// ============================================
// EXAMPLE 1: Using PlatformResponsive for sizing
// ============================================
class ResponsiveExample extends StatelessWidget {
  const ResponsiveExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Responsive Example')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Using responsive width/height
            Container(
              width: PlatformResponsive.w(200),
              height: PlatformResponsive.h(100),
              color: Colors.blue,
              child: const Center(child: Text('Responsive Box')),
            ),
            
            // Using responsive padding
            Padding(
              padding: PlatformResponsive.all(16),
              child: const Text('Responsive Padding'),
            ),
            
            // Using responsive font size
            Text(
              'Responsive Text',
              style: TextStyle(
                fontSize: PlatformResponsive.sp(18),
                fontWeight: FontWeight.bold,
              ),
            ),
            
            // Using responsive border radius
            Container(
              width: 150.rw, // Using extension method
              height: 150.rh,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: PlatformResponsive.circular(20),
              ),
            ),
            
            // Using SizedBox helpers
            PlatformResponsive.sizedBoxH(20),
            
            // Using symmetric padding
            Padding(
              padding: PlatformResponsive.symmetric(horizontal: 16, vertical: 8),
              child: const Text('Symmetric Padding Example'),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// EXAMPLE 2: Using DeviceUtils for device info
// ============================================
class DeviceInfoExample extends StatefulWidget {
  const DeviceInfoExample({super.key});

  @override
  State<DeviceInfoExample> createState() => _DeviceInfoExampleState();
}

class _DeviceInfoExampleState extends State<DeviceInfoExample> {
  String deviceName = 'Loading...';
  String deviceOS = 'Loading...';
  String deviceId = 'Loading...';
  String ipAddress = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    final name = await DeviceUtils.getDeviceName();
    final os = await DeviceUtils.getDeviceOS();
    final id = await DeviceUtils.getDeviceId();
    final ip = await DeviceUtils.getIpAddress();

    setState(() {
      deviceName = name;
      deviceOS = os;
      deviceId = id;
      ipAddress = ip;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device Info Example')),
      body: Padding(
        padding: PlatformResponsive.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Name: $deviceName',
              style: TextStyle(fontSize: PlatformResponsive.sp(16)),
            ),
            PlatformResponsive.sizedBoxH(10),
            Text(
              'Device OS: $deviceOS',
              style: TextStyle(fontSize: PlatformResponsive.sp(16)),
            ),
            PlatformResponsive.sizedBoxH(10),
            Text(
              'Device ID: $deviceId',
              style: TextStyle(fontSize: PlatformResponsive.sp(14)),
            ),
            PlatformResponsive.sizedBoxH(10),
            Text(
              'IP Address: $ipAddress',
              style: TextStyle(fontSize: PlatformResponsive.sp(14)),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// EXTENSION METHOD USAGE QUICK REFERENCE
// ============================================
/*
Use these extension methods for cleaner code:

24.rw   → PlatformResponsive.w(24)
16.rh   → PlatformResponsive.h(16)
14.rsp  → PlatformResponsive.sp(14)
8.rr    → PlatformResponsive.r(8)

COMMON PATTERNS:

1. Responsive Container:
   Container(
     width: 300.rw,
     height: 200.rh,
     padding: PlatformResponsive.all(16),
     decoration: BoxDecoration(
       borderRadius: PlatformResponsive.circular(12),
     ),
   )

2. Responsive Text:
   Text(
     'Hello',
     style: TextStyle(
       fontSize: 20.rsp,
       fontWeight: FontWeight.bold,
     ),
   )

3. Responsive Spacing:
   Column(
     children: [
       const Text('Item 1'),
       PlatformResponsive.sizedBoxH(16),
       const Text('Item 2'),
     ],
   )
*/
