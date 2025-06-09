import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_supabase_database/config/theme/app_theme.dart';
import 'package:flutter_supabase_database/controller/profile_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildCustomScrollView);
  }

  get _buildCustomScrollView => CustomScrollView(slivers: [_buildAppBar]);

  get _buildAppBar => SliverAppBar(
    centerTitle: false,
    title: Text('Profile', style: TextStyle(color: Colors.white)),
    expandedHeight: 250,
    actions: [
      ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(0),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20)),
          backgroundColor: WidgetStatePropertyAll(
            Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Text('Edit Profile', style: TextStyle(color: Colors.white)),
      ),
      SizedBox(width: 10),
    ],
    flexibleSpace: FlexibleSpaceBar(
      expandedTitleScale: 1,
      background: Container(
        height: 250,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            colors: [Color(0xFF06145d), Color(0xFF2a72bf)],
          ),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
        child: _buildProfileInformation,
      ),
    ),
  );

  get _buildProfileInformation {
    return Column(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 88),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Obx(() {
              double size = 88.0;
              if (controller.profileImage.value.isEmpty) {
                return Container(
                  height: size,
                  width: size,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: AppTheme.secondaryColor,
                      size: 40,
                    ),
                  ),
                );
              } else {
                return controller.loadingProfile.value
                    ? Container(
                      height: size,
                      width: size,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: CircularProgressIndicator()),
                    )
                    : CachedNetworkImage(
                      imageUrl: controller.profileImage.value,
                      imageBuilder:
                          (context, imageProvider) => Container(
                            height: size,
                            width: size,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      placeholder:
                          (context, url) => Container(
                            height: size,
                            width: size,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    );
              }
            }),

            Positioned(
              bottom: -5,
              right: -5,
              child: GestureDetector(
                onTap: () async {
                  var userId = controller.getUserId;
                  await controller.uploadProfilePhoto(userId);
                },
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.add, color: AppTheme.secondaryColor),
                ),
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          child: Column(
            spacing: 5,
            children: [
              Text(
                controller.username.value,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Text(
                controller.numberPhone.value,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
