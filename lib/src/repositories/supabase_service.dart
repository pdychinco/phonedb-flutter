// lib/services/supabase_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider<SupabaseService>((ref) {
  return SupabaseService();
});

class SupabaseService {
  static const String _supabaseUrl = 'https://sxelamicmqhqremdnczo.supabase.co';
  static const String _supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN4ZWxhbWljbXFocXJlbWRuY3pvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAxNjQ2OTUsImV4cCI6MjA1NTc0MDY5NX0.FBJ86qg5qI7cWSTyjs0pgnEOlyYdjhhoGx-8a3HnWHU';
  
  late final SupabaseClient client;

  Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: _supabaseUrl,
        anonKey: _supabaseAnonKey,
      );
      client = Supabase.instance.client;
      print('Supabase initialized successfully');
    } catch (e) {
      print('Error initializing Supabase: $e');
      rethrow;
    }
  }

  SupabaseClient get supabaseClient => client;
}