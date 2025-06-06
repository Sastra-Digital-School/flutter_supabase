import 'package:flutter/material.dart';
import 'package:flutter_supabase_database/config/theme/app_theme.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final void Function(int)? onChange;
  const BottomNavigationBarWidget({super.key, this.onChange});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.home,
      Icons.favorite_border_rounded,
      Icons.leaderboard_outlined,
      Icons.person_3_outlined,
    ];

    List<String> title = ['Home', 'Favorite', 'Search', 'Profile'];

    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 35, top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          title.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onChange!(index);
            },
            child:
                _selectedIndex == index
                    ? Container(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                        right: 20,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        spacing: 5,
                        children: [
                          Icon(icons[index], color: AppTheme.primaryColor),
                          Text(
                            title[index],
                            style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                    : Icon(icons[index]),
          ),
        ),
      ),
    );
  }
}
