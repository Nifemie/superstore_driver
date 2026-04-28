import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/controllers/map_controller.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/delivery_request_sheet.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/picking_up_order_sheet.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/arrived_sheet.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/confirm_pickup_sheet.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/pickup_confirmed_sheet.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/delivery_in_progress_sheet.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/delivery_arrived_sheet.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/scan_qr_sheet.dart';
import 'package:superstore_driver/features/Map/Presentation/widgets/package_delivered_sheet.dart';
import 'package:superstore_driver/features/Delivery/Presentation/screens/delivery_summary_screen.dart';
import 'package:superstore_driver/features/Map/Presentation/screens/scan_qr_screen.dart';

// Dashboard State
class DashboardState {
  final int currentIndex;
  
  const DashboardState({
    this.currentIndex = 0,
  });
  
  DashboardState copyWith({int? currentIndex}) {
    return DashboardState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

// Dashboard Controller
class DashboardController extends Notifier<DashboardState> {
  @override
  DashboardState build() => const DashboardState();
  
  void setIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }
  
  // Sync with navigation shell index
  void syncWithShell(int index) {
    if (state.currentIndex != index) {
      state = state.copyWith(currentIndex: index);
    }
  }
}

final dashboardControllerProvider = NotifierProvider<DashboardController, DashboardState>(
  DashboardController.new,
);

// Dashboard Shell Wrapper - Integrates with GoRouter's StatefulNavigationShell
class DashboardShellWrapper extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  
  const DashboardShellWrapper({
    super.key,
    required this.navigationShell,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sync provider state with shell state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardControllerProvider.notifier).syncWithShell(navigationShell.currentIndex);
    });
    
    // Watch for delivery requests
    final mapState = ref.watch(mapControllerProvider);
    
    // Show delivery request sheet when there's an active request
    if (mapState.hasActiveRequest) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          builder: (context) => DeliveryRequestSheet(
            onAccept: () {
              Navigator.pop(context);
              ref.read(mapControllerProvider.notifier).acceptRequest();
            },
            onReject: () {
              Navigator.pop(context);
              ref.read(mapControllerProvider.notifier).rejectRequest();
            },
          ),
        );
      });
    }
    
    // Show picking up order sheet when driver accepted
    if (mapState.isPickingUpOrder) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          builder: (context) => PickingUpOrderSheet(
            onCancel: () {
              Navigator.pop(context);
              ref.read(mapControllerProvider.notifier).cancelPickup();
            },
            onArrived: () {
              Navigator.pop(context);
              ref.read(mapControllerProvider.notifier).arrivedAtPickup();
            },
          ),
        );
      });
    }
    
    // Show arrived sheet when driver arrives at pickup
    if (mapState.hasArrived) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          builder: (context) => ArrivedSheet(
            onCancel: () {
              Navigator.pop(context);
              ref.read(mapControllerProvider.notifier).cancelArrival();
            },
            onConfirmArrival: () {
              Navigator.pop(context);
              ref.read(mapControllerProvider.notifier).confirmArrival();
            },
          ),
        );
      });
    }
    
    // Show confirm pickup sheet when driver confirms arrival
    if (mapState.isConfirmingPickup) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          builder: (context) => ConfirmPickupSheet(
            onCancel: () {
              Navigator.pop(context);
              ref.read(mapControllerProvider.notifier).cancelPickupConfirmation();
            },
            onConfirm: () {
              Navigator.pop(context);
              ref.read(mapControllerProvider.notifier).confirmPickup();
            },
          ),
        );
      });
    }
    
    // Show pickup confirmed sheet after code confirmation
    if (mapState.pickupConfirmed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          builder: (context) => PickupConfirmedSheet(
            onStartTrip: () {
              Navigator.pop(context);
              ref.read(mapControllerProvider.notifier).startTrip();
            },
          ),
        );
      });
    }
    
    // Show delivery in progress sheet when trip starts
    if (mapState.isDeliveryInProgress && !mapState.arrivedAtDestination && !mapState.arrivedAtDestination) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Close any open sheets first
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          builder: (context) => DeliveryInProgressSheet(
            eta: '16 min',
            distance: '20KM',
            onSimulateArrival: () {
              ref.read(mapControllerProvider.notifier).arrivedAtDestinationLocation();
            },
          ),
        );
      });
    }
    
    // Show delivery arrived sheet when driver arrives at destination
    if (mapState.arrivedAtDestination && !mapState.scanningQR) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Close any open sheets first
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          builder: (context) => DeliveryArrivedSheet(
            onCallCustomer: () {
              ref.read(mapControllerProvider.notifier).callCustomer();
            },
            onConfirmDelivery: () {
              Navigator.pop(context);
              ref.read(mapControllerProvider.notifier).confirmDelivery();
            },
          ),
        );
      });
    }
    
    // Show scan QR sheet when delivery is confirmed (but not when already completed)
    if (mapState.scanningQR && !mapState.deliveryCompleted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Close any open sheets first
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          builder: (context) => ScanQRSheet(
            onStartScanning: () {
              // TODO: Implement QR scanner
            },
            onQRScanned: (qrCode) {
              print('QR Code scanned: $qrCode');
              // QR code was scanned successfully
              ref.read(mapControllerProvider.notifier).confirmQRCode();
            },
          ),
        );
      });
    }
    
    // Show package delivered sheet when delivery is completed
    if (mapState.deliveryCompleted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Close any open sheets first
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          builder: (context) => PackageDeliveredSheet(
            onNewDelivery: () {
              Navigator.pop(context);
              ref.read(mapControllerProvider.notifier).startNewDelivery();
            },
            onDeliverySummary: () {
              Navigator.pop(context);
              // Reset delivery completed state
              ref.read(mapControllerProvider.notifier).startNewDelivery();
              // Navigate to summary
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeliverySummaryScreen(),
                ),
              );
            },
          ),
        );
      });
    }
    
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DashboardBottomNav(
        navigationShell: navigationShell,
      ),
    );
  }
}

// Bottom Navigation Widget
class DashboardBottomNav extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  
  const DashboardBottomNav({
    super.key,
    required this.navigationShell,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardControllerProvider);
    
    return SafeArea(
      top: false,
      child: Container(
        height: 68.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildNavItem(
                context,
                index: 0,
                iconPath: 'assets/images/nav_home.png',
                label: 'Home',
                isActive: dashboardState.currentIndex == 0,
                onTap: () => _onTap(context, ref, 0),
                top: 17.h,
                left: 24.w,
                isImage: true,
              ),
            ),
            Expanded(
              child: _buildNavItem(
                context,
                index: 1,
                icon: Icons.map_outlined,
                label: 'Map',
                isActive: dashboardState.currentIndex == 1,
                onTap: () => _onTap(context, ref, 1),
                top: 15.h,
                left: 25.w,
              ),
            ),
            Expanded(
              child: _buildNavItem(
                context,
                index: 2,
                iconPath: 'assets/images/nav_delivery.png',
                label: 'Delivery',
                isActive: dashboardState.currentIndex == 2,
                onTap: () => _onTap(context, ref, 2),
                top: 15.h,
                left: 25.w,
                isImage: true,
              ),
            ),
            Expanded(
              child: _buildNavItem(
                context,
                index: 3,
                iconPath: 'assets/images/nav_more.png',
                label: 'More',
                isActive: dashboardState.currentIndex == 3,
                onTap: () => _onTap(context, ref, 3),
                top: 15.5.h,
                left: 21.w,
                isImage: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _onTap(BuildContext context, WidgetRef ref, int index) {
    // Update provider state
    ref.read(dashboardControllerProvider.notifier).setIndex(index);
    
    // Navigate using shell
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
  
  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    IconData? icon,
    String? iconPath,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    required double top,
    required double left,
    bool isImage = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: top, left: left),
            child: isImage && iconPath != null
                ? Image.asset(
                    iconPath,
                    width: 24.r,
                    height: 24.r,
                    color: isActive ? AppColors.primary : AppColors.textSecondary,
                  )
                : Icon(
                    icon,
                    color: isActive ? AppColors.primary : AppColors.textSecondary,
                    size: 24.r,
                  ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(left: left),
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.primary : AppColors.textSecondary,
                fontSize: 11.sp,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
