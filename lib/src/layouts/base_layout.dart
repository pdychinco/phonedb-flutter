import 'package:flutter/material.dart';
import 'package:phonedb_front/src/component/menu_bar.dart' show BottomNavBar;
import 'package:phonedb_front/routes.dart';

class BaseLayout extends StatelessWidget {
  final Widget child;
  final String currentRoute;

  const BaseLayout({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  int _getCurrentIndex() {
    switch (currentRoute) {
      case AppRoutes.home:
        return 0;
      case AppRoutes.phoneList:
        return 1;
      case AppRoutes.settings:
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavBar(currentIndex: _getCurrentIndex()),
    );
  }
} 