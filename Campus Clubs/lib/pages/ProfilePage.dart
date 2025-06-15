import 'dart:io';
import 'package:campusclubs/components/MyAppBar.dart';
import 'package:campusclubs/config/AppRoutes.dart';
import 'package:campusclubs/config/AppString.dart';
import 'package:campusclubs/config/AppURL.dart';
import 'package:campusclubs/styles/AppColors.dart';
import 'package:campusclubs/styles/AppTexts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import '../components/AppContainer.dart';
import '../components/AppTextButton.dart';
import '../config/UserProvider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? imageBytes;
  File? imageFile;
  Uint8List? coverImageBytes;
  File? coverImageFile;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(String type) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          if (type == 'profile') {
            imageBytes = bytes;
            imageFile = null;
          } else if (type == 'cover') {
            coverImageBytes = bytes;
            coverImageFile = null;
          }
        });
      } else {
        setState(() {
          if (type == 'profile') {
            imageFile = File(pickedFile.path);
            imageBytes = null;
          } else if (type == 'cover') {
            coverImageFile = File(pickedFile.path);
            coverImageBytes = null;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(
        Headding: AppString.profile,
        backpage: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: screenWidth,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: coverImageBytes != null
                          ? MemoryImage(coverImageBytes!)
                          : coverImageFile != null
                          ? FileImage(coverImageFile!)
                          : AssetImage('assets/png/antu.jpg')
                      as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.black, size: 30),
                    onPressed: () {
                      pickImage('cover');
                    },
                  ),
                ),
                Positioned(
                  bottom: -50,
                  left: (screenWidth / 2) - 55,
                  child: Stack(
                    children: [
                      Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: imageBytes != null
                              ? MemoryImage(imageBytes!)
                              : imageFile != null
                              ? FileImage(imageFile!) as ImageProvider
                              : null,
                          child: (imageBytes == null && imageFile == null)
                              ? SvgPicture.asset(
                            'assets/svgicons/user.svg',
                            height: 60,
                          )
                              : null,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.camera_alt, size: 20),
                          onPressed: () {
                            pickImage('profile');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: user == null
                      ? Center(child: Text("No user logged in"))
                      : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text("${user.name}", style: AppTexts.AppHeading),
                        Divider(thickness: 1),
                        Row(
                          children: [
                            Icon(Icons.email_outlined,
                                color: AppColors.icon4, size: 20),
                            SizedBox(width: 5),
                            Text('Email: ${user.email}',
                                style: AppTexts.button),
                          ],
                        ),
                        Divider(thickness: 1),
                        Row(
                          children: [
                            Image.asset('assets/png/regi.png',
                                width: 25,
                                height: 25,
                                color: AppColors.icon4),
                            SizedBox(width: 5),
                            Text('Registration: ${user.registation}',
                                style: AppTexts.button),
                          ],
                        ),
                        Divider(thickness: 1),
                        Row(
                          children: [
                            Image.asset('assets/png/dept.png',
                                width: 20,
                                height: 20,
                                color: AppColors.icon4),
                            SizedBox(width: 5),
                            Text('Department: Software Engineering',
                                style: AppTexts.button),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset('assets/png/versity.png',
                                width: 20,
                                height: 20,
                                color: AppColors.icon4),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                "Shahjalal University of Science And Technology, Sylhet.",
                                style: AppTexts.button,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            AppContainer(
              child: Padding(
                padding: EdgeInsets.only(left: 6),
                child: Row(
                  children: [
                    SvgPicture.asset(AppURL.clubs_svg,
                        height: 25, width: 25, color: AppColors.icon2),
                    Text(" Your Clubs", style: AppTexts.button2),
                  ],
                ),
              ),
            ),
            AppContainer(
              child: AppTextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.clubApproval);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppURL.applications_svg,
                          height: 25, width: 25),
                      Text("  Club Approval", style: AppTexts.button2),
                    ],
                  ),
                ),
              ),
            ),
            AppContainer(
              child: AppTextButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppURL.create_club_svg,
                          height: 25, width: 25, color: AppColors.icon3),
                      Text("  Create Your Club", style: AppTexts.button2),
                    ],
                  ),
                ),
              ),
            ),
            AppContainer(
              child: AppTextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.myclubs);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppURL.explore_svg,
                          height: 25, width: 25, color: AppColors.icon1),
                      Text("  Explore New", style: AppTexts.button2),
                    ],
                  ),
                ),
              ),
            ),
            AppContainer(
              child: AppTextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.profileedit);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppURL.edit_svg,
                          height: 20,
                          width: 20,
                          color: Colors.redAccent),
                      Text("   Edit Personal Info", style: AppTexts.button2),
                    ],
                  ),
                ),
              ),
            ),
            AppContainer(
              child: AppTextButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Row(
                    children: [
                      Icon(Icons.settings_sharp,
                          size: 25, color: AppColors.icon2),
                      Text("  Setting", style: AppTexts.button2),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
