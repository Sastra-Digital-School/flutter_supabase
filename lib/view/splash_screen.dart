import 'package:flutter/material.dart';
import 'package:flutter_supabase_database/controller/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  final controller = Get.put(DashboardController());
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            colors: [Color(0xFF06145d), Color(0xFF2a72bf)],
          ),
        ),
        child: Center(
          child: Text(
            'Welcome to my app',
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
