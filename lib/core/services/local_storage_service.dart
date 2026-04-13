import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/Auth/Logic/register_logic.dart';

class LocalStorageService {
  static const String _registerKey = 'register_state';
  static const String _isLoggedInKey = 'is_logged_in';

  static Future<void> saveRegisterState(RegisterState state) async {
    final prefs = await SharedPreferences.getInstance();
    final data = {
      'firstName': state.firstName,
      'lastName': state.lastName,
      'gender': state.gender,
      'dob': state.dob?.toIso8601String(),
      'email': state.email,
      'phone': state.phone,
      'residentState': state.residentState,
      'city': state.city,
      'identityDocumentPath': state.identityDocumentPath,
      'businessName': state.businessName,
      'businessAddress': state.businessAddress,
      'businessState': state.businessState,
      'businessCity': state.businessCity,
      'businessDocumentPath': state.businessDocumentPath,
      'bankName': state.bankName,
      'accountNumber': state.accountNumber,
      'accountName': state.accountName,
    };
    await prefs.setString(_registerKey, jsonEncode(data));
  }

  static Future<RegisterState?> loadRegisterState() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_registerKey);
    if (jsonString == null) return null;

    final data = jsonDecode(jsonString) as Map<String, dynamic>;
    return RegisterState(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      gender: data['gender'] ?? '',
      dob: data['dob'] != null ? DateTime.parse(data['dob']) : null,
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      residentState: data['residentState'] ?? '',
      city: data['city'] ?? '',
      identityDocumentPath: data['identityDocumentPath'] ?? '',
      businessName: data['businessName'] ?? '',
      businessAddress: data['businessAddress'] ?? '',
      businessState: data['businessState'] ?? '',
      businessCity: data['businessCity'] ?? '',
      businessDocumentPath: data['businessDocumentPath'] ?? '',
      bankName: data['bankName'] ?? '',
      accountNumber: data['accountNumber'] ?? '',
      accountName: data['accountName'] ?? '',
    );
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }
}
