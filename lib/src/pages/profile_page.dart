import 'package:flutter/material.dart';
import 'package:phonedb_front/routes.dart';
import 'package:phonedb_front/src/layouts/base_layout.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      currentRoute: AppRoutes.profile,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              SizedBox(height: 20),
              Text(
                'User Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Profile information will be displayed here'),
            ],
          ),
        ),
      ),
    );
  }
} 