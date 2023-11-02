import 'package:eatery/features/auth/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider  extends ChangeNotifier{
  final AuthRepository authRepository;

  AuthProvider(this.authRepository);


  Future login({required String email, required String password}) async{
    authRepository.loginUser(email: email, password: password);
  }

}
