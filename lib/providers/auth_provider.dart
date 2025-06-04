// lib/providers/auth_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  User? build() {
    // Return current user if exists
    return ref.watch(supabaseClientProvider).auth.currentUser;
  }

  Future<void> signIn(String email, String password) async {
    final response = await ref.read(supabaseClientProvider).auth.signInWithPassword(
      email: email,
      password: password,
    );
    state = response.user;
  }

  Future<void> signOut() async {
    await ref.read(supabaseClientProvider).auth.signOut();
    state = null;
  }
}