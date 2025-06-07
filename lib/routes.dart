import 'package:flutter/material.dart';
import 'package:phonedb_front/src/pages/home_page.dart';
import 'package:phonedb_front/src/pages/phone_list_page.dart';
import 'package:phonedb_front/src/pages/settings_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String phoneList = '/phoneList';
  static const String settings = '/settings';
  
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomePage(),
      phoneList: (context) => const PhoneListPage(),
      settings: (context) => const SettingsPage(),
    };
  }
}