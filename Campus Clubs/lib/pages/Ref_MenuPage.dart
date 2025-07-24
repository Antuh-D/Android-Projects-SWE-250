import 'package:campusclubs/pages/HomePage.dart';
import 'package:campusclubs/pages/SearchPage.dart';
import 'package:campusclubs/styles/AppColors.dart';
import 'package:flutter/material.dart';

import 'MyClubPage.dart';
import 'NotificationPage.dart';

enum Menus{
  home,
  search,
  myclubs,
  notification,
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Menus currentIndex = Menus.home;

  final Map<Menus, Widget> currentPage = {
    Menus.home: HomePage(),
    Menus.search: SearchPage(),
    Menus.myclubs: MyClubPage(),
    Menus.notification: NotificationPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage[currentIndex]!,
      bottomNavigationBar: MyBottomNavigation(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}

class MyBottomNavigation extends StatelessWidget {
  final Menus currentIndex;
  final ValueChanged<Menus> onTap;

  const MyBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.navigator,
        borderRadius: BorderRadius.all(Radius.circular(7)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: Menus.values.map((menu) {
            return Expanded(
              child: _NavBarItem(
                menu: menu,
                isSelected: currentIndex == menu,
                onTap: onTap,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final Menus menu;
  final bool isSelected;
  final ValueChanged<Menus> onTap;

  const _NavBarItem({
    super.key,
    required this.menu,
    required this.isSelected,
    required this.onTap,
  });

  IconData _getIconData(Menus menu) {
    switch (menu) {
      case Menus.home:
        return Icons.home;
      case Menus.search:
        return Icons.search;
      case Menus.myclubs:
        return Icons.newspaper_rounded;
      case Menus.notification:
        return Icons.notification_important_sharp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.appBackground : AppColors.navigator,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: IconButton(
        onPressed: () => onTap(menu),
        icon: Icon(
          _getIconData(menu),
          color: isSelected ? Colors.amber[800] : Colors.grey,
        ),
      ),
    );
  }
}