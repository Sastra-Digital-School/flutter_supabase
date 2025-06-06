import 'dart:async';

import 'package:get/get.dart';

class HomeController extends GetxController {
  var greeting = ''.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _updateGreeting();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateGreeting();
    });
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      greeting.value = 'Good Morning';
    } else if (hour < 18) {
      greeting.value = 'Good Afternoon';
    } else {
      greeting.value = 'Good Evening';
    }
  }

  get getGreeting => greeting.value;

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }
}
