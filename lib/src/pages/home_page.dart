import 'package:flutter/material.dart';
import 'package:phonedb_front/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhoneDB'),
        actions: [
          // Profile button in app bar
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.profile);
            },
          ),
          // Settings button in app bar
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to PhoneDB'),
            const SizedBox(height: 20),
            // Example button to navigate to profile
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.profile);
              },
              child: const Text('Go to Profile'),
            ),
            const SizedBox(height: 10),
            // Example button to navigate to settings
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.settings);
              },
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
} 