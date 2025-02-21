import 'package:campusclubs/styles/AppColors.dart';
import 'package:campusclubs/styles/AppTexts.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.navigator,
      title: Center(child: Text("Campus Club", style: AppTexts.AppHeading,)),
      automaticallyImplyLeading: false,
    );
  }
  Size get preferredSize => const Size.fromHeight(60);
}
