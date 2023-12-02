import 'package:eatery/app.dart';
import 'package:eatery/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase/supabase.dart';

import 'config/config.dart';

void main() {
  final supabase = SupabaseClient(
    Config.supabaseUrl,
    Config.supabaseKey,
  );
  runApp(const ProviderScope(child: App()));
  initFeatures(supabase);
}
