import 'dart:developer';

import 'package:eatery/features/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase/supabase.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider(this.authRepository);

  User? _user;
  String? _message;

  set setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  set setMessage(String? message) {
    _message = message;
    notifyListeners();
  }

  String? get message => _message;

  User? get user => _user;

  Future<void> login({required String email, required String password}) async {
    try {
      final loggedUser =
          await authRepository.loginUser(email: email, password: password);
      if (loggedUser != null) {
        setUser = loggedUser;
        setMessage = 'Login successful';
      } else {
        setMessage = 'Login failed';
        setUser = null;
      }
      return;
    } on AuthException catch (e) {
      setUser = null;
      setMessage = e.message;
      log(e.toString(), name: 'AuthException');
      return;
    } on Exception catch (e) {
      setUser = null;
      setMessage = e.toString();
      log(e.toString(), name: 'Exception');
      return;
    }
  }

  Future<void> verifyOTP(
      {required String otp,
      required String email,
      required OtpType type}) async {
    try {
      final auth =
          await authRepository.verifyOTP(otp: otp, email: email, type: type);
      if (auth.user != null) {
        setUser = auth.user;
        setMessage = 'Account verified!';
      } else {
        setMessage = 'Account verification failed';
        setUser = null;
      }
      return;
    } on AuthException catch (e) {
      setUser = null;
      setMessage = e.message;
      log(e.toString(), name: 'AuthException');
      return;
    } on Exception catch (e) {
      setUser = null;
      setMessage = e.toString();
      log(e.toString(), name: 'Exception');
      return;
    }
  }

  Future<void> logout() async {
    return await authRepository.logout();
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      final createdUser = await authRepository.createUser(
        email: email,
        password: password,
      );
      if (createdUser != null) {
        setUser = createdUser;
        setMessage = 'Registration successful. Verify email address';
      } else {
        setMessage = 'Registration failed';
        setUser = null;
      }
    } on AuthException catch (e) {
      setUser = null;
      setMessage = e.message;
      log(e.toString(), name: 'AuthException');
    } on Exception catch (e) {
      setUser = null;
      setMessage = e.toString();
      log(e.toString(), name: 'Exception');
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      return await authRepository.resetPassword(email: email);
    } catch (e) {
      log(e.toString(), name: 'Exception');
      setUser = null;
      setMessage = e.toString();
    }
  }

  Stream<bool> isUserLoggedIn() => authRepository.isUserLoggedIn();

  Future<bool> updateRestaurantProfile(
      {required String username,
      required String restaurantName,
      required String restaurantLocation,
      required XFile restaurantLogo,
      required ({double latitude, double longitude}) restaurantLatLng}) async {
    try {
      final saved = await authRepository.updateRestaurantProfile(
        restaurantLatLng: restaurantLatLng,
        restaurantLocation: restaurantLocation,
        restaurantName: restaurantName,
        username: username,
        restaurantLogo: restaurantLogo,
      );
      if (saved) {
        setMessage = 'Profile updated';
      } else {
        setMessage = 'Failed to update profile';
      }
      return saved;
    } catch (e) {
      setUser = null;
      setMessage = e.toString();
      log(e.toString(), name: 'Exception');
      return false;
    }
  }

  Future<dynamic> getRestaurant() async {
    try {
      return await authRepository.getRestaurant();
    } catch (e) {
      log(e.toString(), name: 'Exception');
      setUser = null;
      setMessage = e.toString();
    }
  }
}
