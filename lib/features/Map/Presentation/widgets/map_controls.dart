import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart';

class MapControls extends StatelessWidget {
  final MapController mapController;
  final VoidCallback onCurrentLocation;

  const MapControls({
    super.key,
    required this.mapController,
    required this.onCurrentLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16.w,
      top: 60.h,
      child: Column(
        children: [
          _buildControlButton(
            icon: Icons.add,
            onTap: () {
              mapController.move(
                mapController.camera.center,
                mapController.camera.zoom + 1,
              );
            },
          ),
          SizedBox(height: 8.h),
          _buildControlButton(
            icon: Icons.remove,
            onTap: () {
              mapController.move(
                mapController.camera.center,
                mapController.camera.zoom - 1,
              );
            },
          ),
          SizedBox(height: 8.h),
          _buildControlButton(
            icon: Icons.my_location,
            onTap: onCurrentLocation,
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.r,
        height: 48.r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: const Color(0xFF666666),
          size: 24.r,
        ),
      ),
    );
  }
}
