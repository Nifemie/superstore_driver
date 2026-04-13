import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';

class MonthYearPickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final Function(int month, int year) onDone;

  const MonthYearPickerDialog({
    super.key,
    required this.initialDate,
    required this.onDone,
  });

  @override
  State<MonthYearPickerDialog> createState() => _MonthYearPickerDialogState();
}

class _MonthYearPickerDialogState extends State<MonthYearPickerDialog> {
  late int selectedMonth;
  late int selectedYear;
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  final List<int> years = List.generate(DateTime.now().year - 1900 + 1, (index) => 1900 + index);

  late FixedExtentScrollController monthController;
  late FixedExtentScrollController yearController;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.initialDate.month;
    selectedYear = widget.initialDate.year;
    
    monthController = FixedExtentScrollController(initialItem: selectedMonth - 1);
    yearController = FixedExtentScrollController(initialItem: years.indexOf(selectedYear));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          width: 330.w,
          height: 320.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, bottom: 40.h),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: CupertinoPicker(
                        scrollController: monthController,
                        itemExtent: 45.h,
                        onSelectedItemChanged: (index) {
                          setState(() => selectedMonth = index + 1);
                        },
                        children: months.map((m) => Center(
                          child: Text(
                            m,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: months.indexOf(m) + 1 == selectedMonth ? Colors.black : Colors.grey.shade400,
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CupertinoPicker(
                        scrollController: yearController,
                        itemExtent: 45.h,
                        onSelectedItemChanged: (index) {
                          setState(() => selectedYear = years[index]);
                        },
                        children: years.map((y) => Center(
                          child: Text(
                            y.toString(),
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: y == selectedYear ? Colors.black : Colors.grey.shade400,
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              // Selection background highlight
              Positioned.fill(
                child: IgnorePointer(
                  child: Center(
                    child: Container(
                      height: 45.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.05),
                      ),
                    ),
                  ),
                ),
              ),
              // Done Button
              Positioned(
                bottom: -22.h,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      widget.onDone(selectedMonth, selectedYear);
                      context.pop();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(30.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
