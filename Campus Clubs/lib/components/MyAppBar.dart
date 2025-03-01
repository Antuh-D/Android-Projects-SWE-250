import 'package:campusclubs/styles/AppColors.dart';
import 'package:campusclubs/styles/AppTexts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../config/AppURL.dart';

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
    return AppBar(
      backgroundColor: AppColors.navigator,
      title:Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            onProfileClick!=null
            ?Container(
             height: 35,
             decoration: BoxDecoration(
               border: Border.all(
                 color: Colors.black,
                 width: 2,
               ),
               shape: BoxShape.circle,
             ),

             child: IconButton(onPressed: onProfileClick,
                 icon: SvgPicture.asset(
                     AppURL.user,
                     height: 30,
                     width: 30,
                     color: Colors.black
               )
             ),
           ):SizedBox(),

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
