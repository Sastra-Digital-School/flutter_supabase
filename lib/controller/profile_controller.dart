import 'dart:convert';

import 'package:flutter_supabase_database/models/google_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final _supabase = Supabase.instance.client;

  RxString username = ''.obs;

  Future<void> loadProfile() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    final response =
        await _supabase.from('profiles').select().eq('id', userId).single();
    username.value = response['username'] ?? '';
  }

  Future<void> updateProfile(String newUsername) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return;

    await _supabase.from('profiles').upsert({
      'id': userId,
      'username': newUsername,
      'updated_at': DateTime.now().toIso8601String(),
    });

    username.value = newUsername;
  }

  ProductModel productModel = ProductModel();

  var loading = true.obs;

  Future<void> fetchDataFromApi() async {
    var client = http.Client();
    try {
      loading.value = true;
      var response = await client.get(Uri.https('dummyjson.com', 'products'));
      var decodedResponse = jsonDecode(response.body);

      productModel = ProductModel.fromJson(decodedResponse);
    } finally {
      client.close();
      loading.value = false;
    }
  }

  @override
  void onInit() async {
    await fetchDataFromApi();
    await loadProfile();
    super.onInit();
  }
}
