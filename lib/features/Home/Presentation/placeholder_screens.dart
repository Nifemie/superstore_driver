import 'package:flutter/material.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';

class MapPlaceholderScreen extends StatelessWidget {
  const MapPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.map_outlined, size: 64, color: AppColors.primary),
            SizedBox(height: 16),
            Text('Map View', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Coming Soon', style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class DeliveryPlaceholderScreen extends StatelessWidget {
  const DeliveryPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_shipping_outlined, size: 64, color: AppColors.primary),
            SizedBox(height: 16),
            Text('Delivery History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Coming Soon', style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

class MorePlaceholderScreen extends StatelessWidget {
  const MorePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.more_horiz, size: 64, color: AppColors.primary),
            SizedBox(height: 16),
            Text('More Features', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Coming Soon', style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}
