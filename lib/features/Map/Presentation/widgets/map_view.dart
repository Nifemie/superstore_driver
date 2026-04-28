import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/driver_marker.dart';
import 'package:superstore_driver/controllers/map_controller.dart' as map_controller;

class MapView extends StatelessWidget {
  final fm.MapController mapController;
  final LatLng center;
  final double zoom;
  final VoidCallback? onMapReady;
  final map_controller.DeliveryRequest? deliveryRequest;

  const MapView({
    super.key,
    required this.mapController,
    required this.center,
    this.zoom = 15.0,
    this.onMapReady,
    this.deliveryRequest,
  });

  @override
  Widget build(BuildContext context) {
    // Build route points if delivery request exists
    List<LatLng> routePoints = [];
    if (deliveryRequest != null) {
      routePoints = [
        center, // Driver location
        deliveryRequest!.pickupLocation,
        deliveryRequest!.destinationLocation,
      ];
    }

    return fm.FlutterMap(
      mapController: mapController,
      options: fm.MapOptions(
        initialCenter: center,
        initialZoom: zoom,
        minZoom: 5.0,
        maxZoom: 18.0,
        interactionOptions: fm.InteractionOptions(
          flags: fm.InteractiveFlag.all,
        ),
        onMapReady: onMapReady,
      ),
      children: [
        fm.TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.superstore.driver',
          maxZoom: 19,
        ),
        
        // Route polyline
        if (deliveryRequest != null)
          fm.PolylineLayer(
            polylines: [
              fm.Polyline(
                points: routePoints,
                strokeWidth: 4.0,
                color: const Color(0xFFFF7D33),
              ),
            ],
          ),
        
        // Markers
        fm.MarkerLayer(
          markers: [
            // Driver marker
            fm.Marker(
              point: center,
              width: 48,
              height: 48,
              child: const DriverMarker(),
            ),
            
            // Pickup marker
            if (deliveryRequest != null)
              fm.Marker(
                point: deliveryRequest!.pickupLocation,
                width: 40.w,
                height: 40.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                ),
              ),
            
            // Destination marker
            if (deliveryRequest != null)
              fm.Marker(
                point: deliveryRequest!.destinationLocation,
                width: 40.w,
                height: 50.w,
                child: Icon(
                  Icons.location_on,
                  color: const Color(0xFFFF7D33),
                  size: 40.sp,
                ),
              ),
          ],
        ),
        
        // ETA indicator above pickup
        if (deliveryRequest != null)
          fm.MarkerLayer(
            markers: [
              fm.Marker(
                point: deliveryRequest!.pickupLocation,
                width: 60.w,
                height: 80.h,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF7D33),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        deliveryRequest!.eta,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h), // Space for the marker below
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
