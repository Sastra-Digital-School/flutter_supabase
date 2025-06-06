import 'package:flutter_supabase_database/binding/home_binding.dart';
import 'package:flutter_supabase_database/binding/profile_binding.dart';
import 'package:flutter_supabase_database/view/auth_screen.dart';
import 'package:flutter_supabase_database/view/main_screen.dart';
import 'package:flutter_supabase_database/view/profile_screen.dart';
import 'package:flutter_supabase_database/view/splash_screen.dart';
import 'package:flutter_supabase_database/view/home_screen.dart';
import 'package:flutter_supabase_database/view/sign_in_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const dashboard = '/dashboard';
  static const main = '/main';
  static const auth = '/auth';
  static const signIn = '/signin';
  static const home = '/home';
  static const profile = '/profile';

  static final pages = [
    GetPage(name: dashboard, page: () => DashboardScreen()),
    GetPage(name: main, page: () => MainScreen()),
    GetPage(name: auth, page: () => AuthScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: home, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(
      name: profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
  ];
}
