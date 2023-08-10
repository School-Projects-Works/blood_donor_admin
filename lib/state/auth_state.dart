// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:blood_donor_admin/config/routes/routes.dart';
import 'package:blood_donor_admin/core/components/widgets/smart_dialog.dart';
import 'package:blood_donor_admin/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/components/constants/enums.dart';

final authStateProvider = StateNotifierProvider<AuthState, AuthData>((ref) {
  return AuthState();
});

class AuthState extends StateNotifier<AuthData> {
  AuthState() : super(AuthData());

  void setUser(AuthData user) {
    state = user;
  }

  void setEmail(String? email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String? password) {
    state = state.copyWith(password: password);
  }

  void login(BuildContext context)async {
    CustomDialog.showLoading(message: 'Logging in...');
    final user= await FirebaseAuthService.signIn(state.email!, state.password!);
    if(user!=null){
      CustomDialog.dismiss();
      CustomDialog.showToast(message: 'Login Successful',type: ToastType.success);
      if(mounted) {
        AutoRouter.of(context).replace(const HomeRoute());
      }
    }
  }
}

class AuthData {
  String? email;
  String? password;
  AuthData({
    this.email,
    this.password,
  });

  AuthData copyWith({
    String? email,
    String? password,
  }) {
    return AuthData(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) => AuthData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthData(email: $email, password: $password)';

  @override
  bool operator ==(covariant AuthData other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
