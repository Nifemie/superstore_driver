import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String title;
  final String amount;
  final DateTime date;
  final bool isDebit;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    this.isDebit = false,
  });

  String get formattedDate => DateFormat('dd MMM, yyyy - h:mm a').format(date);
  String get sectionHeader => DateFormat('EEE, d MMM').format(date);
}
