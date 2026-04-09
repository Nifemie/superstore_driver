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
  final String businessName;
  final String businessAddress;
  final String businessState;
  final String businessCity;
  final String businessDocumentPath;
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
    this.businessName = '',
    this.businessAddress = '',
    this.businessState = '',
    this.businessCity = '',
    this.businessDocumentPath = '',
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
    String? businessName,
    String? businessAddress,
    String? businessState,
    String? businessCity,
    String? businessDocumentPath,
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
      businessName: businessName ?? this.businessName,
      businessAddress: businessAddress ?? this.businessAddress,
      businessState: businessState ?? this.businessState,
      businessCity: businessCity ?? this.businessCity,
      businessDocumentPath: businessDocumentPath ?? this.businessDocumentPath,
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

  void updateBusinessFields({
    String? businessName,
    String? businessAddress,
    String? businessState,
    String? businessCity,
  }) {
    state = state.copyWith(
      businessName: businessName,
      businessAddress: businessAddress,
      businessState: businessState,
      businessCity: businessCity,
    );
  }

  void updateIdentityDocument(String path) {
    state = state.copyWith(identityDocumentPath: path);
  }

  void updateBusinessDocument(String path) {
    state = state.copyWith(businessDocumentPath: path);
  }

  void submit(BuildContext context) {
    state = state.copyWith(isLoading: true);
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(isLoading: false);
      Navigator.pushNamed(context, '/identity_verification');
    });
  }
}
