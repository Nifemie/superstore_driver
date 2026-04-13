import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'models/transaction_model.dart';

class TransactionState {
  final DateTime? selectedDate;
  final List<Transaction> allTransactions;
  final bool isLoading;

  TransactionState({
    this.selectedDate,
    required this.allTransactions,
    this.isLoading = false,
  });

  TransactionState copyWith({
    DateTime? selectedDate,
    List<Transaction>? allTransactions,
    bool? isLoading,
    bool clearDate = false,
  }) {
    return TransactionState(
      selectedDate: clearDate ? null : (selectedDate ?? this.selectedDate),
      allTransactions: allTransactions ?? this.allTransactions,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  String get formattedDate => selectedDate != null 
      ? DateFormat('MMM yyyy').format(selectedDate!) 
      : 'All Transactions';

  List<Transaction> get filteredTransactions {
    if (selectedDate == null) return allTransactions;
    return allTransactions.where((t) => 
      t.date.month == selectedDate!.month && t.date.year == selectedDate!.year
    ).toList();
  }
}

class TransactionLogic extends StateNotifier<TransactionState> {
  TransactionLogic() : super(TransactionState(
    selectedDate: null, // Start with "All"
    allTransactions: _mockData,
  ));

  void updateDate(int month, int year) {
    state = state.copyWith(selectedDate: DateTime(year, month), clearDate: false);
  }

  void resetFilter() {
    state = state.copyWith(clearDate: true);
  }

  static final List<Transaction> _mockData = [
    Transaction(id: '1', title: 'Money withdrawn', amount: '-₦ 10,000', date: DateTime(2024, 2, 10, 16, 13), isDebit: true),
    Transaction(id: '2', title: 'Money withdrawn', amount: '-₦ 10,000', date: DateTime(2024, 2, 10, 14, 05), isDebit: true),
    Transaction(id: '3', title: 'Delivery earnings', amount: '+₦ 2000', date: DateTime(2024, 2, 10, 12, 30)),
    Transaction(id: '4', title: 'Delivery earnings', amount: '+₦ 2000', date: DateTime(2024, 2, 10, 11, 45)),
    Transaction(id: '5', title: 'Delivery earnings', amount: '+₦ 2000', date: DateTime(2024, 2, 10, 09, 15)),
    
    Transaction(id: '6', title: 'Money withdrawn', amount: '-₦ 5,000', date: DateTime(2024, 2, 9, 18, 00), isDebit: true),
    Transaction(id: '7', title: 'Delivery earnings', amount: '+₦ 3500', date: DateTime(2024, 2, 9, 14, 20)),
    Transaction(id: '8', title: 'Delivery earnings', amount: '+₦ 2000', date: DateTime(2024, 2, 9, 08, 10)),
    
    Transaction(id: '9', title: 'Money withdrawn', amount: '-₦ 5,000', date: DateTime(2021, 3, 15, 12, 00), isDebit: true),
    Transaction(id: '10', title: 'Bonus reward', amount: '+₦ 10,000', date: DateTime(2021, 3, 14, 09, 00)),
    
    Transaction(id: '11', title: 'Old earnings', amount: '+₦ 100,000', date: DateTime(1995, 5, 20, 09, 00)),
    Transaction(id: '12', title: 'Opening balance', amount: '+₦ 5,000', date: DateTime(1995, 5, 01, 00, 00)),
  ];
}

final transactionLogicProvider = StateNotifierProvider<TransactionLogic, TransactionState>((ref) {
  return TransactionLogic();
});
