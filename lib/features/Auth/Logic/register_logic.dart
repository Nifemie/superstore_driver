import 'package:flutter/material.dart';
import 'package:nigeria_lg_state_city/nigeria_lg_state_city.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_logic.g.dart';

class RegisterState {
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime? dob;
  final String email;
  final String phone;
  final String residentState;
  final String city;
  final String identityDocumentPath;
  final bool isLoading;

  const RegisterState({
    this.firstName = '',
    this.lastName = '',
    this.gender = '',
    this.dob,
    this.email = '',
    this.phone = '',
    this.residentState = '',
    this.city = '',
    this.identityDocumentPath = '',
    this.isLoading = false,
  });

  RegisterState copyWith({
    String? firstName,
    String? lastName,
    String? gender,
    DateTime? dob,
    String? email,
    String? phone,
    String? residentState,
    String? city,
    String? identityDocumentPath,
    bool? isLoading,
  }) {
    return RegisterState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      residentState: residentState ?? this.residentState,
      city: city ?? this.city,
      identityDocumentPath: identityDocumentPath ?? this.identityDocumentPath,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

@riverpod
class RegisterLogic extends _$RegisterLogic {
  @override
  RegisterState build() => const RegisterState();

  void updateField({
    String? firstName,
    String? lastName,
    String? gender,
    DateTime? dob,
    String? email,
    String? phone,
    String? residentState,
    String? city,
  }) {
    state = state.copyWith(
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      dob: dob,
      email: email,
      phone: phone,
      residentState: residentState,
      city: city,
    );
  }

  void updateIdentityDocument(String path) {
    state = state.copyWith(identityDocumentPath: path);
  }

  void submit(BuildContext context) {
    state = state.copyWith(isLoading: true);
    // API Call Logic
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(isLoading: false);
      Navigator.pushNamed(context, '/identity_verification');
    });
  }
}
