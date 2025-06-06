import 'package:get/get.dart';

class MainController extends GetxController {
  final _selectIndex = 0.obs;

  void changeIndex(int index) {
    _selectIndex.value = index;
  }

  get getIndex => _selectIndex.value;
}
