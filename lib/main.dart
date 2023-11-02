import 'package:eatery/app.dart';
import 'package:eatery/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

void main() {
  final supabase = SupabaseClient(
    'https://xyzcompany.supabase.co',
    'public-anon-key',
  );
  runApp(const App());
  initFeatures(supabase);
}
