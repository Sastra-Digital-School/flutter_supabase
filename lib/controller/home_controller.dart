import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_supabase_database/models/popular_item.dart';
import 'package:flutter_supabase_database/service/local_service.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  var greeting = ''.obs;

  Timer? _timer;

  final _userId = ''.obs;
  String get userId => _userId.value;

  @override
  void onInit() async {
    super.onInit();
    _userId.value = LocalStorageService.instance.getString('user_id') ?? '';
    _updateGreeting();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateGreeting();
    });

    popular.value = await loadPopularWithSignedUrls();
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

  Future<void> pickAndUploadMultipleImagesAndInsertPopular(
    String userId,
  ) async {
    // Pick multiple images
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.image,
      withData: true,
    );

    if (result == null) return;

    Get.dialog(
      Container(
        margin: EdgeInsets.only(top: 200, bottom: 200, left: 50, right: 50),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Lottie.asset('assets/lottie/Animation - 1749819414543.json'),
          ),
        ),
      ),
      barrierDismissible: false,
    );

    final files = result.files;

    try {
      for (final file in files) {
        final fileBytes = file.bytes;
        final fileName =
            'public/user_$userId/image_${DateTime.now().millisecondsSinceEpoch}_${file.name}';

        if (fileBytes == null) continue;

        debugPrint('Uploading image: $fileName');

        // Upload image to Storage
        await Supabase.instance.client.storage
            .from('images')
            .uploadBinary(
              fileName,
              fileBytes,
              fileOptions: const FileOptions(upsert: true),
            );

        debugPrint('Uploaded image: $fileName');

        // Now insert into popular table
        var uuid = Uuid();
        String popularId = uuid.v4();

        await Supabase.instance.client.from('popular').insert({
          'id': popularId,
          'name': 'Popular Item $popularId',
          'image': fileName,
        });
        debugPrint('Inserted into popular table with id = $popularId');
      }
      popular.value = await loadPopularWithSignedUrls();
    } catch (e) {
      debugPrint('Error uploading image or inserting popular: $e');
    } finally {
      // Dismiss dialog when done (whether success or error)
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }

  RxList<PopularItem> popular = <PopularItem>[].obs;

  Future<List<PopularItem>> loadPopularWithSignedUrls() async {
    final response = await Supabase.instance.client.from('popular').select();

    final popularItemsRaw = response as List<dynamic>;

    List<PopularItem> popularItems = [];

    for (var item in popularItemsRaw) {
      final model = PopularItem.fromMap(item);

      String? signedUrl;

      try {
        signedUrl = await Supabase.instance.client.storage
            .from('images')
            .createSignedUrl(model.imagePath, 3600);
      } catch (e) {
        debugPrint('Error generating signed URL for ${model.imagePath}: $e');
        signedUrl = null;
      }

      popularItems.add(model.copyWithSignedUrl(signedUrl ?? ''));
    }

    return popularItems;
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
  }
}
