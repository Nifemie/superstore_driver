import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';

class DeliverySummaryMap extends StatelessWidget {
  const DeliverySummaryMap({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample coordinates for pickup and destination
    final pickupLocation = LatLng(12.0, 8.6);
    final destinationLocation = LatLng(11.98, 8.58);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      width: double.infinity,
      height: 250.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: fm.FlutterMap(
        options: fm.MapOptions(
          initialCenter: pickupLocation,
          initialZoom: 15.0,
          interactionOptions: const fm.InteractionOptions(
            flags: fm.InteractiveFlag.all,
          ),
        ),
        children: [
          fm.TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.superstore_driver',
          ),
          fm.PolylineLayer(
            polylines: [
              fm.Polyline(
                points: [pickupLocation, destinationLocation],
                color: const Color(0xFFFF7D33),
                strokeWidth: 4.0,
              ),
            ],
          ),
          fm.MarkerLayer(
            markers: [
              // Pickup marker
              fm.Marker(
                point: pickupLocation,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.circle,
                    color: Colors.white,
                    size: 16.r,
                  ),
                ),
              ),
              // Destination marker
              fm.Marker(
                point: destinationLocation,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7D33),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 20.r,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}
