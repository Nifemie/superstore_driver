import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:superstore_driver/core/widgets/rounded_input_field.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({super.key});

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  String? _selectedBank;
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();

  final List<String> _banks = [
    'United Bank of Africa',
    'First Bank of Nigeria',
    'Guaranty Trust Bank',
    'Access Bank',
    'Zenith Bank',
    'Fidelity Bank',
    'Union Bank',
    'Stanbic IBTC',
    'Sterling Bank',
    'Wema Bank',
  ];

  @override
  void dispose() {
    _accountNumberController.dispose();
    _accountNameController.dispose();
    super.dispose();
  }

  void _showBankPicker() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          itemCount: _banks.length,
          separatorBuilder: (_, __) => Divider(height: 1.h, color: const Color(0xFFEEEEEE)),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                _banks[index],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Inter',
                  color: const Color(0xFF1E1E1E),
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedBank = _banks[index];
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E), size: 24),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Add bank account',
          style: TextStyle(
            color: const Color(0xFF1E1E1E),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                    // Bank name
                    Text(
                      'Bank name',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E1E1E),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    RoundedInputField(
                      hintText: 'Choose bank',
                      readOnly: true,
                      onTap: _showBankPicker,
                      controller: TextEditingController(text: _selectedBank ?? ''),
                      suffixIcon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1E1E1E)),
                    ),
                    SizedBox(height: 24.h),
                    // Account number
                    Text(
                      'Account number',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E1E1E),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    RoundedInputField(
                      hintText: 'write account number',
                      controller: _accountNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    SizedBox(height: 24.h),
                    // Account name
                    Text(
                      'Account name',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E1E1E),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 8.h),
                    RoundedInputField(
                      hintText: 'e.g. John Doe',
                      controller: _accountNameController,
                    ),
                    SizedBox(height: 60.h),
                    PrimaryButton(
                      text: 'Save',
                      onPressed: () {
                        if (_selectedBank == null || 
                            _accountNumberController.text.isEmpty || 
                            _accountNameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // Temporary functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Bank account saved (not permanent)')),
                        );
                        context.pop();
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
