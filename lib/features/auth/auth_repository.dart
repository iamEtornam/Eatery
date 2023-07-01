import 'package:supabase/supabase.dart';

abstract class AuthRepository {
  Future loginUser({required String email, required String password});
  Future otherLoginUser({required Provider provider});
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
  Future otherLoginUser({required Provider provider}) async {
    final idToken = '';
    await supabase.auth.signInWithIdToken(provider: provider, idToken: idToken);

    final Session? session = supabase.auth.currentSession;
    final String? oAuthToken = session?.providerToken;

    return session != null || oAuthToken != null;
  }
}
