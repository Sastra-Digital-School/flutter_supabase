import 'dart:convert';

import 'package:flutter_supabase_database/models/product_detail_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductDetailControll extends GetxController {
  var loading = true.obs;

  ProductDetailModel productDetailModel = ProductDetailModel();

  Future<void> fetchDataFromApiBYID({required String id}) async {
    var client = http.Client();
    try {
      loading.value = true;
      var response = await client.get(
        Uri.https('dummyjson.com', 'products/$id'),
      );
      var decodedResponse = jsonDecode(response.body);

      productDetailModel = ProductDetailModel.fromJson(decodedResponse);
    } finally {
      client.close();
      loading.value = false;
    }
  }

  @override
  void onInit() async {
    var id = Get.parameters['id'];
    await fetchDataFromApiBYID(id: id!);
    super.onInit();
  }
}
