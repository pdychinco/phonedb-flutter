import 'package:flutter/material.dart';
import 'package:phonedb_front/src/pages/home_page.dart';
import 'package:phonedb_front/src/pages/profile_page.dart';
import 'package:phonedb_front/src/pages/settings_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String settings = '/settings';
  
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomePage(),
      profile: (context) => const ProfilePage(),
      settings: (context) => const SettingsPage(),
    };
  }
}