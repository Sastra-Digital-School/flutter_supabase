import 'package:flutter/material.dart';
import 'package:flutter_supabase_database/models/profile_model.dart';
import 'package:flutter_supabase_database/service/local_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController {
  final _supabase = Supabase.instance.client;

  final _userId = ''.obs;
  get getUserId => _userId.value;

  RxString username = ''.obs;
  RxString numberPhone = ''.obs;

  final ImagePicker _picker = ImagePicker();
  var avatarSignedUrl = ''.obs;
  var profileImage = ''.obs;

  var loading = true.obs;
  var loadingProfile = false.obs;

  ProfileModel profileModel = ProfileModel();

  Future<void> loadProfile(String? userid) async {
    try {
      loading.value = true;

      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) return;

      final response =
          await _supabase.from('profiles').select().eq('id', userId).single();

      profileModel = ProfileModel.fromJson(response);

      username.value = profileModel.username ?? '';
      numberPhone.value = profileModel.phonenumber ?? '';
      final avatarPath = profileModel.profileImage ?? '';

      if (avatarPath.isNotEmpty) {
        try {
          final signedUrl = await _supabase.storage
              .from('images')
              .createSignedUrl(avatarPath, 3600);
          profileImage.value = signedUrl;
        } catch (e) {
          debugPrint('Error creating signed URL: $e');
          // Fallback → show default avatar
          profileImage.value = '';
        }
      } else {
        profileImage.value = '';
      }

      loading.value = false;
    } catch (e) {
      debugPrint('Error loading: $e');
      Get.snackbar(
        'Error',
        '$e',
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
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

  Future<void> uploadProfilePhoto(String userId) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;

    final fileBytes = await pickedFile.readAsBytes();
    final fileName = 'public/avatar_$userId.png'; // path in bucket

    try {
      loadingProfile.value = true;
      // 1. Load current profile_image from profile (to delete old one)
      final profileResponse =
          await Supabase.instance.client
              .from('profiles')
              .select('profile_image')
              .eq('id', userId)
              .single();

      final oldAvatarPath = profileResponse['profile_image'] as String?;

      // 2. Upload new avatar (upsert = replace if same name)
      await Supabase.instance.client.storage
          .from('images')
          .uploadBinary(
            fileName,
            fileBytes,
            fileOptions: const FileOptions(upsert: true),
          );

      // 3. If old avatar exists and path is different → delete it
      if (oldAvatarPath != null && oldAvatarPath != fileName) {
        await Supabase.instance.client.storage.from('images').remove([
          oldAvatarPath,
        ]);
      }

      // 4. Update profile_image → store just PATH, not URL!
      await Supabase.instance.client
          .from('profiles')
          .update({'profile_image': fileName})
          .eq('id', userId);

      // 5. Generate new signed URL for display
      await loadProfile(userId);
      loadingProfile.value = false;
    } catch (e) {
      loadingProfile.value = false;
      debugPrint('Error uploading avatar: $e');
    }
  }

  @override
  void onInit() async {
    _userId.value = LocalStorageService.instance.getString('user_id') ?? '';
    await loadProfile(_userId.value);
    super.onInit();
  }
}
