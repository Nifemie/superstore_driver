import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQRSheet extends StatefulWidget {
  final VoidCallback? onStartScanning;
  final Function(String)? onQRScanned;

  const ScanQRSheet({
    super.key,
    this.onStartScanning,
    this.onQRScanned,
  });

  @override
  State<ScanQRSheet> createState() => _ScanQRSheetState();
}

class _ScanQRSheetState extends State<ScanQRSheet> {
  bool showError = false;
  bool isScanning = false;
  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            SizedBox(height: 24.h),

            // Title
            Text(
              'Scan customers QR',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E1E1E),
                fontFamily: 'Inter',
              ),
            ),

            SizedBox(height: 24.h),

            // Camera or QR Code Placeholder
            if (!isScanning)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                width: double.infinity,
                height: 280.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // QR Code Icon
                      Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: const Color(0xFFE0E0E0),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.qr_code_2,
                          size: 70.r,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'QR Code',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF999999),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                width: double.infinity,
                height: 280.h,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: MobileScanner(
                  controller: controller,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      if (barcode.rawValue != null) {
                        widget.onQRScanned?.call(barcode.rawValue!);
                        setState(() {
                          isScanning = false;
                        });
                        print('QR Code scanned: ${barcode.rawValue}');
                      }
                    }
                  },
                ),
              ),

            SizedBox(height: 32.h),

            // Error Message (text only, no container)
            if (showError)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: const Color(0xFFFF4B4B),
                      size: 18.r,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'Incorrect OTP: Check the code and try again',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFFF4B4B),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            if (showError) SizedBox(height: 24.h),

            // Start Scanning Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (isScanning) {
                      // Stop scanning - trigger QR scanned callback to move to next sheet
                      widget.onQRScanned?.call('QR_CODE_SCANNED');
                    }
                    setState(() {
                      isScanning = !isScanning;
                    });
                    widget.onStartScanning?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7D33),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    elevation: 0,
                  ),
                  child: Text(
                    isScanning ? 'Stop scanning' : 'Start scanning',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
