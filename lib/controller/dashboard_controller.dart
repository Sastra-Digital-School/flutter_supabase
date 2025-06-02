import 'package:flutter_supabase_database/config/routes/app_routes.dart';
import 'package:flutter_supabase_database/service/local_service.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var userId = ''.obs;

  @override
  void onInit() {
    userId.value = LocalStorageService.instance.getString('user_id') ?? '';

    Future.delayed(const Duration(seconds: 1), () {
      if (userId.value == '') {
        Get.offAllNamed(AppRoutes.auth);
      } else {
        Get.offAllNamed(AppRoutes.profile);
      }
    });

    super.onInit();
  }
}
