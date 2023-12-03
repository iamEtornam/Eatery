import 'dart:developer';
import 'dart:typed_data';

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

  Future getRestaurant();

  Future<void> logout();
  Future<AuthResponse> verifyOTP(
      {required String otp, required String email, required OtpType type});
}

class AuthRepositoryImpl extends AuthRepository {
  final SupabaseClient supabase;

  AuthRepositoryImpl(this.supabase);

  Stream<bool> userState = Stream.value(false);

  @override
  Future<User?> loginUser(
      {required String email, required String password}) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
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
  Stream<bool> isUserLoggedIn() {
    supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        // handle signIn
        userState = Stream.value(true);
      }
    });
    return userState;
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
      final fileName = '${DateTime.now().toIso8601String()}.$extension';
      final filePath = fileName;
      await supabase.storage.from('avatars').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: mimeType),
          );
      final imageUrlResponse = await supabase.storage
          .from('logos')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      return imageUrlResponse;
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
  Future<List> getRestaurant() async {
    try {
      final res = await supabase
          .from('restaurants')
          .select()
          .match({'user_id': supabase.auth.currentUser!.id});
      print(res);
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
