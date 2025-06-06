import 'package:flutter/material.dart';
import 'package:flutter_supabase_database/controller/main_controller.dart';
import 'package:flutter_supabase_database/view/home_screen.dart';
import 'package:flutter_supabase_database/view/profile_screen.dart';
import 'package:flutter_supabase_database/widgets/bottom_navigation_bar_widget.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final controller = Get.put(MainController());
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> screen = [
      HomeScreen(),
      SizedBox(),
      SizedBox(),
      ProfileScreen(),
    ];
    return Obx(
      () => Scaffold(
        body: screen[controller.getIndex],
        bottomNavigationBar: _buildBottomNavigationBar,
      ),
    );
  }

  get _buildBottomNavigationBar {
    return BottomNavigationBarWidget(
      onChange: (index) {
        controller.changeIndex(index);
      },
    );
  }
}
