import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

// Delivery Request Model
class DeliveryRequest {
  final LatLng pickupLocation;
  final String pickupAddress;
  final LatLng destinationLocation;
  final String destinationAddress;
  final String distance;
  final String estimatedPay;
  final String eta;

  const DeliveryRequest({
    required this.pickupLocation,
    required this.pickupAddress,
    required this.destinationLocation,
    required this.destinationAddress,
    required this.distance,
    required this.estimatedPay,
    required this.eta,
  });
}

// Map State
class MapState {
  final LatLng? currentLocation;
  final bool isOnline;
  final bool isLoadingLocation;
  final bool isFindingRequests;
  final bool hasActiveRequest;
  final bool isPickingUpOrder;
  final bool hasArrived;
  final bool isConfirmingPickup;
  final bool pickupConfirmed;
  final bool isDeliveryInProgress;
  final bool arrivedAtDestination;
  final bool scanningQR;
  final bool deliveryCompleted;
  final DeliveryRequest? activeDeliveryRequest;
  final double zoom;
  final String? errorMessage;

  const MapState({
    this.currentLocation,
    this.isOnline = false,
    this.isLoadingLocation = false,
    this.isFindingRequests = false,
    this.hasActiveRequest = false,
    this.isPickingUpOrder = false,
    this.hasArrived = false,
    this.isConfirmingPickup = false,
    this.pickupConfirmed = false,
    this.isDeliveryInProgress = false,
    this.arrivedAtDestination = false,
    this.scanningQR = false,
    this.deliveryCompleted = false,
    this.activeDeliveryRequest,
    this.zoom = 15.0,
    this.errorMessage,
  });

  MapState copyWith({
    LatLng? currentLocation,
    bool? isOnline,
    bool? isLoadingLocation,
    bool? isFindingRequests,
    bool? hasActiveRequest,
    bool? isPickingUpOrder,
    bool? hasArrived,
    bool? isConfirmingPickup,
    bool? pickupConfirmed,
    bool? isDeliveryInProgress,
    bool? arrivedAtDestination,
    bool? scanningQR,
    bool? deliveryCompleted,
    DeliveryRequest? activeDeliveryRequest,
    double? zoom,
    String? errorMessage,
    bool clearError = false,
    bool clearDeliveryRequest = false,
  }) {
    return MapState(
      currentLocation: currentLocation ?? this.currentLocation,
      isOnline: isOnline ?? this.isOnline,
      isLoadingLocation: isLoadingLocation ?? this.isLoadingLocation,
      isFindingRequests: isFindingRequests ?? this.isFindingRequests,
      hasActiveRequest: hasActiveRequest ?? this.hasActiveRequest,
      isPickingUpOrder: isPickingUpOrder ?? this.isPickingUpOrder,
      hasArrived: hasArrived ?? this.hasArrived,
      isConfirmingPickup: isConfirmingPickup ?? this.isConfirmingPickup,
      pickupConfirmed: pickupConfirmed ?? this.pickupConfirmed,
      isDeliveryInProgress: isDeliveryInProgress ?? this.isDeliveryInProgress,
      arrivedAtDestination: arrivedAtDestination ?? this.arrivedAtDestination,
      scanningQR: scanningQR ?? this.scanningQR,
      deliveryCompleted: deliveryCompleted ?? this.deliveryCompleted,
      activeDeliveryRequest: clearDeliveryRequest ? null : (activeDeliveryRequest ?? this.activeDeliveryRequest),
      zoom: zoom ?? this.zoom,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

// Map Controller
class MapController extends Notifier<MapState> {
  @override
  MapState build() => const MapState();

  void setLocation(LatLng location) {
    state = state.copyWith(
      currentLocation: location,
      isLoadingLocation: false,
      clearError: true,
    );
  }

  void setLoadingLocation(bool loading) {
    state = state.copyWith(isLoadingLocation: loading);
  }

  void toggleOnline() {
    final newOnlineState = !state.isOnline;
    state = state.copyWith(isOnline: newOnlineState);
    
    // If going online, show "finding requests" for 3 seconds, then show request
    if (newOnlineState) {
      state = state.copyWith(isFindingRequests: true);
      Future.delayed(const Duration(seconds: 3), () {
        // Create mock delivery request with locations near current location
        final currentLoc = state.currentLocation;
        if (currentLoc != null) {
          final mockRequest = DeliveryRequest(
            pickupLocation: LatLng(
              currentLoc.latitude + 0.01,
              currentLoc.longitude + 0.005,
            ),
            pickupAddress: 'Jujin Labu, Janbulo, Kano state',
            destinationLocation: LatLng(
              currentLoc.latitude - 0.015,
              currentLoc.longitude - 0.008,
            ),
            destinationAddress: '62 Hawan Dawaki Kano state',
            distance: '12KM',
            estimatedPay: 'N 2000',
            eta: '4 min',
          );
          
          state = state.copyWith(
            isFindingRequests: false,
            hasActiveRequest: true,
            activeDeliveryRequest: mockRequest,
          );
        }
      });
    } else {
      // If going offline, clear any active requests
      state = state.copyWith(
        hasActiveRequest: false,
        clearDeliveryRequest: true,
      );
    }
  }

  void acceptRequest() {
    state = state.copyWith(
      hasActiveRequest: false,
      isPickingUpOrder: true,
    );
  }

  void rejectRequest() {
    state = state.copyWith(
      hasActiveRequest: false,
      clearDeliveryRequest: true,
    );
    // After rejecting, start finding again
    state = state.copyWith(isFindingRequests: true);
    Future.delayed(const Duration(seconds: 3), () {
      final currentLoc = state.currentLocation;
      if (currentLoc != null) {
        final mockRequest = DeliveryRequest(
          pickupLocation: LatLng(
            currentLoc.latitude + 0.01,
            currentLoc.longitude + 0.005,
          ),
          pickupAddress: 'Jujin Labu, Janbulo, Kano state',
          destinationLocation: LatLng(
            currentLoc.latitude - 0.015,
            currentLoc.longitude - 0.008,
          ),
          destinationAddress: '62 Hawan Dawaki Kano state',
          distance: '12KM',
          estimatedPay: 'N 2000',
          eta: '4 min',
        );
        
        state = state.copyWith(
          isFindingRequests: false,
          hasActiveRequest: true,
          activeDeliveryRequest: mockRequest,
        );
      }
    });
  }

  void cancelPickup() {
    state = state.copyWith(
      isPickingUpOrder: false,
      clearDeliveryRequest: true,
    );
    // After canceling, start finding again
    state = state.copyWith(isFindingRequests: true);
    Future.delayed(const Duration(seconds: 3), () {
      final currentLoc = state.currentLocation;
      if (currentLoc != null) {
        final mockRequest = DeliveryRequest(
          pickupLocation: LatLng(
            currentLoc.latitude + 0.01,
            currentLoc.longitude + 0.005,
          ),
          pickupAddress: 'Jujin Labu, Janbulo, Kano state',
          destinationLocation: LatLng(
            currentLoc.latitude - 0.015,
            currentLoc.longitude - 0.008,
          ),
          destinationAddress: '62 Hawan Dawaki Kano state',
          distance: '12KM',
          estimatedPay: 'N 2000',
          eta: '4 min',
        );
        
        state = state.copyWith(
          isFindingRequests: false,
          hasActiveRequest: true,
          activeDeliveryRequest: mockRequest,
        );
      }
    });
  }

  void arrivedAtPickup() {
    state = state.copyWith(
      isPickingUpOrder: false,
      hasArrived: true,
    );
  }

  void confirmArrival() {
    state = state.copyWith(
      hasArrived: false,
      isConfirmingPickup: true,
    );
  }

  void cancelArrival() {
    state = state.copyWith(
      hasArrived: false,
      isPickingUpOrder: true,
    );
  }

  void confirmPickup() {
    state = state.copyWith(
      isConfirmingPickup: false,
      pickupConfirmed: true,
    );
  }

  void cancelPickupConfirmation() {
    state = state.copyWith(
      isConfirmingPickup: false,
      hasArrived: true,
    );
  }

  void startTrip() {
    state = state.copyWith(
      pickupConfirmed: false,
      isDeliveryInProgress: true,
    );
  }

  void arrivedAtDestinationLocation() {
    state = state.copyWith(arrivedAtDestination: true);
  }

  void callCustomer() {
    // TODO: Implement actual phone call functionality
    // For now, just a placeholder for the callback
  }

  void confirmDelivery() {
    state = state.copyWith(
      arrivedAtDestination: false,
      scanningQR: true,
    );
  }

  void confirmQRCode() {
    state = state.copyWith(
      scanningQR: false,
      deliveryCompleted: true,
    );
  }

  void startNewDelivery() {
    state = state.copyWith(
      deliveryCompleted: false,
      isDeliveryInProgress: false,
      clearDeliveryRequest: true,
    );
    // Start finding requests again
    state = state.copyWith(isFindingRequests: true);
    Future.delayed(const Duration(seconds: 3), () {
      final currentLoc = state.currentLocation;
      if (currentLoc != null) {
        final mockRequest = DeliveryRequest(
          pickupLocation: LatLng(
            currentLoc.latitude + 0.01,
            currentLoc.longitude + 0.005,
          ),
          pickupAddress: 'Jujin Labu, Janbulo, Kano state',
          destinationLocation: LatLng(
            currentLoc.latitude - 0.015,
            currentLoc.longitude - 0.008,
          ),
          destinationAddress: '62 Hawan Dawaki Kano state',
          distance: '12KM',
          estimatedPay: 'N 2000',
          eta: '4 min',
        );
        
        state = state.copyWith(
          isFindingRequests: false,
          hasActiveRequest: true,
          activeDeliveryRequest: mockRequest,
        );
      }
    });
  }

  void viewDeliverySummary() {
    // TODO: Navigate to delivery summary screen
  }

  void setZoom(double zoom) {
    state = state.copyWith(zoom: zoom);
  }

  void setError(String error) {
    state = state.copyWith(
      errorMessage: error,
      isLoadingLocation: false,
    );
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

final mapControllerProvider = NotifierProvider<MapController, MapState>(
  MapController.new,
);
