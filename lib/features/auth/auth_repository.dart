import 'package:supabase/supabase.dart';

abstract class AuthRepository {
  Future loginUser({required String email, required String password});
  Future createUser({
    required String email,
    required String password,
    required String username,
    required String restaurantName,
    required String restaurantLocation,
    required String restaurantLogo,
    required (double latitude, double logitude) restaurantLatLng,
  });
}

class AuthRepositoryImpl extends AuthRepository {
  final SupabaseClient supabase;

  AuthRepositoryImpl(this.supabase);

  @override
  Future loginUser({required String email, required String password}) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final Session? session = res.session;
    final User? user = res.user;
    return session != null || user != null;
  }

  @override
  Future createUser(
      {required String email,
      required String password,
      required String username,
      required String restaurantName,
      required String restaurantLocation,
      required String restaurantLogo,
      required (double, double) restaurantLatLng}) async {
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'username': username,
        'restaurant_name': restaurantName,
        'restaurant_location': restaurantLocation,
        'restaurant_logo': restaurantLogo,
        'restaurant_latlng': '${restaurantLatLng.$1},${restaurantLatLng.$2}'
      },
    );
    final Session? session = res.session;
    final User? user = res.user;

     return session != null || user != null;
  }
}
