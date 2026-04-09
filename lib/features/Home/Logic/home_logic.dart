import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_logic.g.dart';

class HomeState {
  final bool isOnline;
  final bool showEarnings;
  final double totalEarnings;
  final double todayEarnings;
  final String onlineTime;
  final int totalRidesToday;

  const HomeState({
    this.isOnline = false,
    this.showEarnings = true,
    this.totalEarnings = 150000.00,
    this.todayEarnings = 30000.00,
    this.onlineTime = '1hr 12min',
    this.totalRidesToday = 2,
  });

  HomeState copyWith({
    bool? isOnline,
    bool? showEarnings,
    double? totalEarnings,
    double? todayEarnings,
    String? onlineTime,
    int? totalRidesToday,
  }) {
    return HomeState(
      isOnline: isOnline ?? this.isOnline,
      showEarnings: showEarnings ?? this.showEarnings,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      todayEarnings: todayEarnings ?? this.todayEarnings,
      onlineTime: onlineTime ?? this.onlineTime,
      totalRidesToday: totalRidesToday ?? this.totalRidesToday,
    );
  }
}

@riverpod
class HomeLogic extends _$HomeLogic {
  @override
  HomeState build() => const HomeState();

  void toggleOnline() {
    state = state.copyWith(isOnline: !state.isOnline);
  }

  void toggleEarningsVisibility() {
    state = state.copyWith(showEarnings: !state.showEarnings);
  }
}
