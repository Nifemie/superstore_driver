import 'package:intl/intl.dart';

extension CurrencyFormatter on num {
  String toCurrency() {
    final s = toStringAsFixed(0);
    final formatted = s.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
    return '₦ $formatted';
  }
}

extension StringCurrencyFormatter on String {
  String formatAmountString() {
    try {
      final sign = startsWith('-') ? '-' : (startsWith('+') ? '+' : '');
      final cleanAmount = replaceAll(RegExp(r'[^0-9]'), '');
      if (cleanAmount.isEmpty) return this;
      
      final valueS = cleanAmount;
      final formatted = valueS.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      );
      return '$sign₦ $formatted';
    } catch (_) {
      return this;
    }
  }
}
