import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_supabase_database/config/theme/app_theme.dart';
import 'package:flutter_supabase_database/controller/auth_controller.dart';
import 'package:flutter_supabase_database/controller/home_controller.dart';
import 'package:flutter_supabase_database/controller/profile_controller.dart';
import 'package:flutter_supabase_database/widgets/card_image_widget.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  final profileController = Get.put(ProfileController());
  final authController = Get.put(AuthController());
  final usernameCtrl = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          profileController.loading.value
              ? Scaffold(body: Center(child: CircularProgressIndicator()))
              : Scaffold(appBar: _buildAppBar, body: _buildBody),
    );
  }

  get _buildAppBar {
    return AppBar(
      title: Row(
        spacing: 10,
        children: [
          CircleAvatar(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  'Hi ${profileController.username.value}',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              Text("${controller.getGreeting}", style: TextStyle(fontSize: 18)),
            ],
          ),
        ],
      ),
      actions: [
        Icon(Icons.notifications_none_rounded),
        SizedBox(width: 10),
        // IconButton(icon: Icon(Icons.logout), onPressed: authController.signOut),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(68),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            spacing: 20,
            children: [
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: 50,
                  child: SearchBar(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    padding: WidgetStatePropertyAll(EdgeInsets.only(left: 15)),
                    elevation: WidgetStatePropertyAll(1),
                    leading: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Discover a city',
                    hintStyle: WidgetStatePropertyAll(
                      TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.tune, color: Colors.white, size: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  get _buildBody {
    List<String> popularCity = ['Paris', 'Kyoto', 'Machu', 'New York'];

    List<String> popularCityImage = [
      'https://static.independent.co.uk/2025/04/25/13/42/iStock-1498516775.jpg',
      'https://i0.wp.com/www.touristjapan.com/wp-content/uploads/2025/01/map-of-kyoto-japan-travel-scaled.jpg?fit=2560%2C1707&ssl=1',
      'https://news.yale.edu/sites/default/files/styles/full/public/ynews-machu_picchu_peru-wiki.jpg?itok=2UrS7Hw8',
      'https://cdn.britannica.com/61/93061-050-99147DCE/Statue-of-Liberty-Island-New-York-Bay.jpg',
    ];

    var decoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
    );

    return ListView(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
          decoration: decoration,
          child: Column(
            spacing: 20,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    'Show all',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  popularCity.length,
                  (index) => Column(
                    spacing: 5,
                    children: [
                      CachedNetworkImage(
                        imageUrl: popularCityImage[index],
                        imageBuilder:
                            (context, imageProvider) => Container(
                              height: 68,
                              width: 68,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(popularCityImage[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        placeholder:
                            (context, url) => Container(
                              height: 68,
                              width: 68,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.image,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),

                      Text(popularCity[index]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recommended',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              'Show all',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 268,
          child: PageView.builder(
            itemCount: 3,
            clipBehavior: Clip.none,
            controller: PageController(viewportFraction: 0.99),
            itemBuilder: (context, index) {
              return CardImageWidget(
                decoration: decoration,
                popularCityImage: popularCityImage,
              );
            },
          ),
        ),
      ],
    );
  }

  // get _buildBody {
  //   return Padding(
  //     padding: EdgeInsets.all(16),
  //     child: Obx(() {
  //       usernameCtrl.text = profileController.username.value;
  //       var productData = profileController.productModel.products;
  //       return profileController.loading.value
  //           ? Center(child: CircularProgressIndicator())
  //           : SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 TextField(
  //                   controller: usernameCtrl,
  //                   decoration: InputDecoration(labelText: 'Username'),
  //                 ),
  //                 ElevatedButton(
  //                   onPressed:
  //                       () =>
  //                           profileController.updateProfile(usernameCtrl.text),
  //                   child: Text(
  //                     "Update",
  //                     style: TextStyle(color: Colors.white),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //     }),
  //   );
  // }
}
