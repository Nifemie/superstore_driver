# Map Feature - Planning Document

## Current Status
- ✅ Folder structure created
- ✅ Placeholder screen exists in `lib/features/Home/Presentation/placeholder_screens.dart`
- ⏳ Ready to implement real Map functionality

## Folder Structure
```
lib/features/Map/
├── Data/                          # For future API integration
├── Presentation/
│   ├── screens/                   # Main map screens
│   └── widgets/                   # Reusable map widgets
└── MAP_FEATURE_PLAN.md           # This file
```

## Typical Map Features for Delivery Driver App

Based on the app being a delivery driver platform, here are common features to discuss:

### 1. **Live Map View** 🗺️
- Real-time map showing driver's current location
- Google Maps or other map provider integration
- Zoom controls, current location button
- Map type switcher (normal, satellite, terrain)

### 2. **Delivery Route Display** 📍
- Show pickup location (store/warehouse)
- Show delivery destination (customer location)
- Route line between pickup and delivery
- Estimated distance and time
- Turn-by-turn navigation integration

### 3. **Active Orders on Map** 📦
- Display all available/assigned orders as markers
- Different marker colors for:
  - Pickup locations (e.g., orange)
  - Delivery locations (e.g., green)
  - Completed deliveries (e.g., gray)
- Tap marker to see order details

### 4. **Navigation Integration** 🧭
- "Start Navigation" button
- Opens Google Maps/Waze/Apple Maps
- Pass coordinates for turn-by-turn directions
- In-app navigation (advanced)

### 5. **Geofencing** 📡
- Detect when driver arrives at pickup location
- Detect when driver arrives at delivery location
- Auto-update order status based on location
- Notify driver when near destination

### 6. **Location Tracking** 📌
- Continuous GPS tracking while online
- Send location updates to backend
- Show movement trail/history
- Battery-efficient location updates

### 7. **Order Details Overlay** 📋
- Bottom sheet with current order info
- Customer name, address, phone
- Order items and special instructions
- Actions: Call customer, Start navigation, Mark delivered

### 8. **Multi-Stop Route Optimization** 🚗
- Show multiple deliveries on map
- Suggest optimal route order
- Batch delivery support
- Route recalculation

### 9. **Map Filters** 🔍
- Filter by order status (pending, in-progress, completed)
- Filter by distance radius
- Filter by delivery time window
- Show/hide specific order types

### 10. **Offline Map Support** 💾
- Cache map tiles for offline use
- Work in areas with poor connectivity
- Queue location updates when offline

## Questions to Discuss

### Priority Features (Choose what to implement first)
1. **Basic Map View**
   - Just show a map with driver's current location?
   - Which map provider? (Google Maps, Mapbox, OpenStreetMap)

2. **Order Display**
   - Show active orders on the map?
   - How many orders at once? (single order vs multiple)

3. **Navigation**
   - In-app navigation or external app integration?
   - Just show route or full turn-by-turn?

4. **Real-time Updates**
   - Track driver location in real-time?
   - Update backend with location?

5. **UI/UX**
   - Full-screen map or map with bottom sheet?
   - What controls/buttons on the map?
   - Dark mode support for night driving?

### Technical Decisions
1. **Map Package**
   - `google_maps_flutter` (most popular, requires API key)
   - `flutter_map` (open source, uses OpenStreetMap)
   - `mapbox_gl` (Mapbox, good features)

2. **Location Services**
   - `geolocator` (location tracking)
   - `location` (alternative)
   - Background location tracking?

3. **State Management**
   - Continue with Riverpod?
   - Create `MapController`?

4. **API Integration**
   - What endpoints exist for:
     - Getting active orders
     - Updating driver location
     - Getting route directions

## Suggested MVP (Minimum Viable Product)

For a first implementation, I suggest:

### Phase 1: Basic Map (Start Here)
```
✓ Display map centered on driver's location
✓ Show current location marker
✓ Map controls (zoom, current location button)
✓ Simple UI with map taking most of screen
```

### Phase 2: Order Display
```
✓ Show active order(s) as markers
✓ Tap marker to see order details
✓ Bottom sheet with order info
✓ "Start Navigation" button
```

### Phase 3: Navigation
```
✓ Draw route line from driver to destination
✓ Show distance and ETA
✓ Open external navigation app
```

### Phase 4: Real-time Updates
```
✓ Track location in background
✓ Send updates to backend
✓ Update order status based on location
```

## Mock Data Structure

For development without API, we can use:

```dart
class DeliveryOrder {
  final String id;
  final String customerName;
  final String customerPhone;
  final LatLng pickupLocation;
  final String pickupAddress;
  final LatLng deliveryLocation;
  final String deliveryAddress;
  final OrderStatus status;
  final List<OrderItem> items;
  final String specialInstructions;
  final double distance; // in km
  final int estimatedTime; // in minutes
}

enum OrderStatus {
  pending,      // Not started
  enRoute,      // Driver heading to pickup
  pickedUp,     // Picked up, heading to delivery
  delivered,    // Completed
  cancelled,    // Cancelled
}
```

## Next Steps

Please let me know:

1. **What's the main goal?**
   - Just show a map?
   - Show orders on map?
   - Full navigation system?

2. **What data do you have?**
   - Do you have order data with coordinates?
   - Is there a backend API?
   - Should we use mock data for now?

3. **Which features are priority?**
   - Pick from the list above
   - Or describe your specific needs

4. **Map provider preference?**
   - Google Maps (requires API key, paid after quota)
   - OpenStreetMap (free, open source)
   - Other?

5. **Design reference?**
   - Do you have a design/mockup?
   - Should I follow Uber/DoorDash style?
   - Custom design?

Once you clarify these, I'll start building the Map feature with the right approach!
