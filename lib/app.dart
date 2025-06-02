import 'package:flutter/material.dart';
import 'package:flutter_supabase_database/config/theme/app_theme.dart';
import 'package:flutter_supabase_database/config/routes/app_routes.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.dashboard,
      getPages: AppRoutes.pages,
    );
  }
}
