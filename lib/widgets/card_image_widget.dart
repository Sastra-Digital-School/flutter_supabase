import 'package:flutter/material.dart';
import 'package:flutter_supabase_database/config/theme/app_theme.dart';

class CardImageWidget extends StatelessWidget {
  const CardImageWidget({
    super.key,
    required this.decoration,
    required this.popularCityImage,
  });

  final BoxDecoration decoration;
  final List<String> popularCityImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 6, right: 6),
      decoration: decoration,
      padding: EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 168,
                decoration: decoration.copyWith(
                  image: DecorationImage(
                    image: NetworkImage(popularCityImage[3]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: decoration.copyWith(
                    color: Colors.white.withValues(alpha: 0.68),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.favorite, color: AppTheme.primaryColor),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Grand Canyon National Park',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '277 miles away',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
