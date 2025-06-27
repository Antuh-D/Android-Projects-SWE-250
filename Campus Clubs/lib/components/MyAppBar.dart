import 'dart:convert';

import 'package:campusclubs/styles/AppColors.dart';
import 'package:campusclubs/styles/AppTexts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../config/AppURL.dart';
import '../config/UserProvider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback ?onProfileClick;
  final VoidCallback ?onSettingsClick;
  final String ?Headding;
  final bool ?backpage;
  final String ?imageUrl;

  const MyAppBar({
    super.key,
    this.onProfileClick,
    this.onSettingsClick,
    this.Headding,
    this.backpage=false,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return AppBar(
      backgroundColor: AppColors.navigator,
      title:Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            onProfileClick != null
                ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: IconButton(
                onPressed: onProfileClick,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: user != null && user.profilePicture!="null"
                    ? ClipOval(
                  child: Image.memory(
                    base64Decode(user.profilePicture),
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                )
                    : SvgPicture.asset(
                  AppURL.user,
                  height: 30,
                  width: 30,
                  color: Colors.black,
                ),
              ),
            )
                : SizedBox(),
            Spacer(),
           Center(
               child: Text(Headding ??'', style: AppTexts.AppHeading,)
           ),
            Spacer(),
            onSettingsClick!=null
            ?IconButton(onPressed:onSettingsClick , icon: Icon(Icons.settings)):SizedBox(),
          ],
        ),
      ),
      automaticallyImplyLeading: backpage ?? false,
      leading: backpage == true
              ? IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                Navigator.of(context).pop(); // This goes back in the stack
               },
            )
        : null,
    );
  }
  Size get preferredSize => const Size.fromHeight(60);
}
