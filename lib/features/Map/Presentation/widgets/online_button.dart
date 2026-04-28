import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/controllers/map_controller.dart';

class OnlineButton extends ConsumerWidget {
  const OnlineButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(mapControllerProvider);
    final controller = ref.read(mapControllerProvider.notifier);

    // Both online and offline buttons go edge to edge (no margin)
    return Container(
      width: double.infinity,
      height: 56.h,
      margin: EdgeInsets.only(
        top: 12.h,
        bottom: 12.h,
      ),
      child: ElevatedButton(
        onPressed: () => controller.toggleOnline(),
        style: ElevatedButton.styleFrom(
          backgroundColor: mapState.isOnline
              ? const Color(0xFFFF4B4B) // Red when online (Go Offline)
              : const Color(0xFF4CAF50), // Green when offline (Go Online)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // No border radius (square)
          ),
          elevation: 0,
        ),
        child: Text(
          mapState.isOnline ? 'Go Offline' : 'Go Online',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}
