import 'dart:developer';
import 'dart:typed_data';

import 'package:eatery/models/restaurant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase/supabase.dart';

abstract class AuthRepository {
  Future<User?> loginUser({required String email, required String password});
  Stream<bool> isUserLoggedIn();
  Future<void> resetPassword({required String email});
  Future<User?> createUser({
    required String email,
    required String password,
  });

  Future<bool> updateRestaurantProfile(
      {required String username,
      required String restaurantName,
      required String restaurantLocation,
      required XFile restaurantLogo,
      required ({double latitude, double longitude}) restaurantLatLng});

  Future<List<Restaurant>> getRestaurant();

  Future<void> logout();
  Future<AuthResponse> verifyOTP(
      {required String otp, required String email, required OtpType type});
  bool userLoginState();
}

class AuthRepositoryImpl extends AuthRepository {
  final SupabaseClient supabase;

  AuthRepositoryImpl(this.supabase);

  @override
  Future<User?> loginUser(
      {required String email, required String password}) async {
    final res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return res.user;
  }

  @override
  Future<User?> createUser({
    required String email,
    required String password,
  }) async {
    final AuthResponse res =
        await supabase.auth.signUp(email: email, password: password);

    return res.user;
  }

  @override
  Future<void> resetPassword({required String email}) async {
    return await supabase.auth.resetPasswordForEmail(email);
  }

  @override
  Stream<bool> isUserLoggedIn() async* {
    bool userState = false;
    supabase.auth.onAuthStateChange.listen((data) {
      log(data.toString(), name: 'isUserLoggedIn');
      final AuthChangeEvent event = data.event;
      if ([
        AuthChangeEvent.signedOut,
        AuthChangeEvent.userDeleted,
        AuthChangeEvent.passwordRecovery,
        AuthChangeEvent.mfaChallengeVerified
      ].contains(event)) {
        userState = false;
      } else {
        userState = true;
      }
    });
    yield userState;
  }

  @override
  Future<bool> updateRestaurantProfile(
      {required String username,
      required String restaurantName,
      required String restaurantLocation,
      required XFile restaurantLogo,
      required ({double latitude, double longitude}) restaurantLatLng}) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return false;
      final bytes = await restaurantLogo.readAsBytes();
      final ex = restaurantLogo.path.split('.').last;
      final logoUrl = await uploadLogo(
          bytes: bytes,
          extension: ex,
          mimeType: restaurantLogo.mimeType ?? 'image/jpeg');

      final body = {
        'user_id': user.id,
        'username': username,
        'restaurant_name': restaurantName,
        'restaurant_location': restaurantLocation,
        'restaurant_logo': logoUrl,
        'restaurant_lat': restaurantLatLng.latitude,
        'restaurant_lng': restaurantLatLng.longitude,
        'updated_at': DateTime.now().toIso8601String(),
        'created_at': DateTime.now().toIso8601String(),
      };

      final res = await supabase.from('restaurants').insert(body).select();
      return res != null;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<String> uploadLogo(
      {required Uint8List bytes,
      required String extension,
      required String mimeType}) async {
    try {
      log(supabase.auth.currentSession?.accessToken ?? 'no data');
      final userId = supabase.auth.currentUser?.id;

      final filePath = '/$userId/logo';
      await supabase.storage.from('logos').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(
                contentType: mimeType, cacheControl: '3600', upsert: true),
          );

      final String publicUrl =
          supabase.storage.from('logos').getPublicUrl(filePath);
      return publicUrl;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() {
    try {
      return supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> verifyOTP(
      {required String otp,
      required String email,
      required OtpType type}) async {
    try {
      return supabase.auth.verifyOTP(token: otp, type: type, email: email);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Restaurant>> getRestaurant() async {
    try {
      final List<dynamic> res = await supabase
          .from('restaurants')
          .select()
          .match({'user_id': supabase.auth.currentUser!.id});
      return res.map((json) => Restaurant.fromJson(json)).toList();
    } catch (e) {
      log(e.toString(), name: 'getRestaurant');
      rethrow;
    }
  }

  @override
  bool userLoginState() {
    try {
      final user = supabase.auth.currentUser;
      return user != null;
    } catch (e) {
      rethrow;
    }
  }
}
