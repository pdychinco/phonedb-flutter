// lib/providers/supabase_provider.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod/riverpod.dart';

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});