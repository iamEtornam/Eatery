import 'package:eatery/features/auth/auth_provider.dart';
import 'package:eatery/features/auth/auth_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase/supabase.dart';

final getIt = GetIt.instance;

void initFeatures(SupabaseClient supabaseClient) {
  /// `AuthProvider`
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl(supabaseClient));
  getIt.registerSingleton<AuthProvider>(AuthProvider(getIt.get()));
}
