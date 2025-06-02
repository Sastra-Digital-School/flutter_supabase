import 'package:flutter/material.dart';
import 'package:flutter_supabase_database/config/routes/app_routes.dart';
import 'package:flutter_supabase_database/service/local_service.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final conPassCtrl = TextEditingController();

  final _isChecked = false.obs;

  get getIsChecked => _isChecked.value;

  // void setIsCheckeds() {
  //   if (passCtrl.text == conPassCtrl.text) {
  //     _isChecked.value = !_isChecked.value;
  //   } else {
  //     _isChecked.value = false;
  //   }
  // }

  void setIsChecked(bool? newValue) {
    if (passCtrl.text != '' && conPassCtrl.text != '' && emailCtrl.text != '') {
      if (passCtrl.text == conPassCtrl.text) {
        _isChecked.value = newValue!;
      } else {
        _isChecked.value = false;
      }
    }
  }

  final _supabase = Supabase.instance.client;

  var loading = false.obs;

  Future<void> signUp(String email, String password) async {
    try {
      loading.value = true;

      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        loading.value = false;
        Get.toNamed(AppRoutes.profile);
      }
    } on AuthException catch (e) {
      if (e.statusCode == '422') {
        Get.offAndToNamed(AppRoutes.signIn);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      loading.value = false;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      loading.value = true;

      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        LocalStorageService.instance.setString(
          'user_id',
          response.user?.id ?? '',
        );
        loading.value = false;
        Get.offAndToNamed(AppRoutes.profile);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    LocalStorageService.instance.remove('user_id');
    Get.offAllNamed(AppRoutes.auth);
  }

  User? get currentUser => _supabase.auth.currentUser;
}
