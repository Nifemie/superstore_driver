import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_map/flutter_map.dart' as fm;
import 'package:latlong2/latlong.dart';
import 'package:superstore_driver/controllers/map_controller.dart';
import 'package:superstore_driver/core/services/location_service.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/map_view.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/map_controls.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/online_button.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/finding_requests_overlay.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/delivery_request_sheet.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final fm.MapController _mapController = fm.MapController();
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    // Delay provider modification until after build
    Future.microtask(() => _initializeLocation());
  }

  Future<void> _initializeLocation() async {
    if (!mounted) return;
    
    final controller = ref.read(mapControllerProvider.notifier);
    controller.setLoadingLocation(true);

    try {
      final location = await LocationService.getCurrentLocation();
      if (location != null && mounted) {
        controller.setLocation(location);
        // Only move map if it's ready
        if (_isMapReady) {
          _mapController.move(location, 15.0);
        }
      }
    } catch (e) {
      if (mounted) {
        controller.setError(e.toString());
        _showErrorDialog(e.toString());
      }
    }
  }

  void _onMapReady() {
    setState(() {
      _isMapReady = true;
    });
    
    // Move to current location if we already have it
    final currentLocation = ref.read(mapControllerProvider).currentLocation;
    if (currentLocation != null) {
      _mapController.move(currentLocation, 15.0);
    }
  }

  void _onCurrentLocationTap() async {
    if (!mounted || !_isMapReady) return;
    
    final controller = ref.read(mapControllerProvider.notifier);
    controller.setLoadingLocation(true);

    try {
      final location = await LocationService.getCurrentLocation();
      if (location != null && mounted) {
        controller.setLocation(location);
        _mapController.move(location, 15.0);
      }
    } catch (e) {
      if (mounted) {
        controller.setError(e.toString());
        _showErrorDialog(e.toString());
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
          if (message.contains('disabled') || message.contains('denied'))
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                LocationService.openLocationSettings();
              },
              child: const Text('Open Settings'),
            ),
        ],
      ),
    );
  }

  void _fitBoundsToRoute(DeliveryRequest request) {
    if (!_isMapReady || !mounted) return;
    
    final currentLoc = ref.read(mapControllerProvider).currentLocation;
    if (currentLoc == null) return;

    // Calculate bounds that include all three points
    final points = [
      currentLoc,
      request.pickupLocation,
      request.destinationLocation,
    ];

    double minLat = points[0].latitude;
    double maxLat = points[0].latitude;
    double minLng = points[0].longitude;
    double maxLng = points[0].longitude;

    for (var point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    // Add padding
    final latPadding = (maxLat - minLat) * 0.3;
    final lngPadding = (maxLng - minLng) * 0.3;

    _mapController.fitCamera(
      fm.CameraFit.bounds(
        bounds: fm.LatLngBounds(
          LatLng(minLat - latPadding, minLng - lngPadding),
          LatLng(maxLat + latPadding, maxLng + lngPadding),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapControllerProvider);

    // Adjust map camera when delivery request appears
    if (mapState.activeDeliveryRequest != null && _isMapReady) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fitBoundsToRoute(mapState.activeDeliveryRequest!);
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          // Map View
          if (mapState.currentLocation != null)
            MapView(
              mapController: _mapController,
              center: mapState.currentLocation!,
              zoom: mapState.zoom,
              onMapReady: _onMapReady,
              deliveryRequest: mapState.activeDeliveryRequest,
            )
          else
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: const Color(0xFFFF7D33),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Loading map...',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFF666666),
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),

          // Map Controls
          if (mapState.currentLocation != null && !mapState.isFindingRequests)
            MapControls(
              mapController: _mapController,
              onCurrentLocation: _onCurrentLocationTap,
            ),

          // Online Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 68.h, // Above bottom nav
            child: const OnlineButton(),
          ),

          // Finding Requests Overlay (under the button, above nav bar)
          if (mapState.isFindingRequests)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0, // Right above nav bar
              child: const FindingRequestsOverlay(),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
