import 'package:campusclubs/pages/HomePage.dart';
import 'package:campusclubs/pages/SearchPage.dart';
import 'package:campusclubs/styles/AppColors.dart';
import 'package:flutter/material.dart';

import 'NotificationPage.dart';

enum Menus{
  home,
  search,
  favorite,
  notification,
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Menus currentIndex = Menus.home;

  final Map<Menus, Widget> currentPage ={
    Menus.home : HomePage(),
    Menus.search: SearchPage(),
    Menus.favorite: Text("This is Favorite page"),
    Menus.notification:NotificationPage() ,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:currentPage[currentIndex]! ,
      bottomNavigationBar: MyBottomNavigation(
          currentIndex: currentIndex,
        onTap: (value){
            setState(() {
              currentIndex = value;
            });
        },
      ),
    );
  }
}

class MyBottomNavigation extends StatelessWidget{
  final Menus currentIndex;
  final ValueChanged<Menus> onTap;

  const MyBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap
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
          )
        ],
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              //home icon
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: currentIndex==Menus.home? AppColors.appBackground : AppColors.navigator,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: IconButton(
                    onPressed:() => onTap(Menus.home) ,
                    icon: Icon(
                        Icons.home,
                        color: currentIndex==Menus.home? Colors.amber[800] : Colors.grey,

                    ),

                ),
              ),
              Spacer(),

              //search icon
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: currentIndex==Menus.search? AppColors.appBackground : AppColors.navigator,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: IconButton(
                    onPressed: ()=> onTap(Menus.search),
                    icon: Icon(
                        Icons.search,
                        color: currentIndex==Menus.search? Colors.amber[800] : Colors.grey
                    )
                ),
              ),
              Spacer(),

              //favorite icon
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: currentIndex==Menus.favorite? AppColors.appBackground : AppColors.navigator,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: IconButton(
                    onPressed: ()=> onTap(Menus.favorite),
                    icon: Icon(
                        Icons.newspaper_rounded,
                        color: currentIndex==Menus.favorite? Colors.amber[800] : Colors.grey ,
                    )
                ),
              ),
              Spacer(),
              
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: currentIndex==Menus.notification? AppColors.appBackground : AppColors.navigator,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: IconButton(
                    onPressed: ()=>onTap(Menus.notification),
                    icon: Icon(
                        Icons.notification_important_sharp,
                        color: currentIndex==Menus.notification? Colors.amber[800] : Colors.grey
                    )
                ),
              )
            ],
          ),
      ),
    );
  }

}
