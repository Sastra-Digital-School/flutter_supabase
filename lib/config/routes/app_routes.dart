import 'package:flutter_supabase_database/view/auth_screen.dart';
import 'package:flutter_supabase_database/view/product_detail.dart';
import 'package:flutter_supabase_database/view/splash_screen.dart';
import 'package:flutter_supabase_database/view/profile_screen.dart';
import 'package:flutter_supabase_database/view/sign_in_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const dashboard = '/dashboard';
  static const auth = '/auth';
  static const signIn = '/signin';
  static const profile = '/profile';
  static const productdetail = '/productdetail';

  static final pages = [
    GetPage(name: dashboard, page: () => DashboardScreen()),
    GetPage(name: auth, page: () => AuthScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: profile, page: () => ProfileScreen()),
    GetPage(name: productdetail, page: () => ProductDetail()),
  ];
}
