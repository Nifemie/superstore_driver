import 'package:flutter_riverpod/flutter_riverpod.dart';

class WithdrawalState {
  final String amount; // The raw digits entered
  final double feeRate; // 1% as seen in screenshot (1200 / 120000)

  const WithdrawalState({
    this.amount = '0',
    this.feeRate = 0.01,
  });

  double get amountValue => double.tryParse(amount) ?? 0.0;
  double get fee => amountValue * feeRate;
  double get total => amountValue; // Based on screenshot "Amount Total"

  WithdrawalState copyWith({
    String? amount,
    double? feeRate,
  }) {
    return WithdrawalState(
      amount: amount ?? this.amount,
      feeRate: feeRate ?? this.feeRate,
    );
  }
}

class WithdrawalController extends Notifier<WithdrawalState> {
  @override
  WithdrawalState build() => const WithdrawalState();

  void addDigit(String digit) {
    if (state.amount == '0') {
      state = state.copyWith(amount: digit);
    } else {
      state = state.copyWith(amount: state.amount + digit);
    }
  }

  void removeDigit() {
    if (state.amount.length <= 1) {
      state = state.copyWith(amount: '0');
    } else {
      state = state.copyWith(amount: state.amount.substring(0, state.amount.length - 1));
    }
  }

  void clear() {
    state = state.copyWith(amount: '0');
  }
}

final withdrawalControllerProvider = NotifierProvider<WithdrawalController, WithdrawalState>(WithdrawalController.new);
