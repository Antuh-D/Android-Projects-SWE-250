import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:campusclubs/components/MyAppBar.dart';
import 'package:campusclubs/config/AppRoutes.dart';
import 'package:campusclubs/config/AppString.dart';
import 'package:campusclubs/config/AppURL.dart';
import 'package:campusclubs/styles/AppColors.dart';
import 'package:campusclubs/styles/AppTexts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import '../components/AppContainer.dart';
import '../components/AppTextButton.dart';
import '../config/ClubProvider.dart';
import '../config/UserProvider.dart';
import 'AppAllClubViewPage.dart';

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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;


    final clubProvider = Provider.of<ClubProvider>(context);
    final clubs = clubProvider.clubs;

    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(
        Headding: AppString.profile,
        backpage: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            //profile and cover picture
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: screenWidth,
                  height: 300,
                  decoration: BoxDecoration(
                    image: user != null && user.coverPicture!= "null"
                        ? DecorationImage(
                          image: MemoryImage(base64Decode(user.coverPicture)),
                          fit: BoxFit.cover,
                          )
                        : DecorationImage(image: AssetImage('assets/png/antu.jpg')),
                  ),
                ),
                //cover pic
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt, color: Colors.black, size: 30),
                    onPressed: () {
                      // pickImage('profile');
                      pickFile('cover');
                    },
                  ),
                ),
                //profile pic
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
                              ? FileImage(imageFile!)
                              : (user != null && user.profilePicture!="null")
                              ? MemoryImage(base64Decode(user.profilePicture))
                              : null,
                          child: (imageBytes == null &&
                              imageFile == null &&
                              (user == null && user?.profilePicture=="null"))
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
                           // pickImage('profile');
                            pickFile('profile');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),

            //profile info card
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
                            Text('Department: ${user.department}',
                                style: AppTexts.button),
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(
                          children: [
                            Image.asset('assets/png/versity.png',
                                width: 20,
                                height: 20,
                                color: AppColors.icon4),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                "Institute: ${user.university}",
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

            //join or suggest clubs
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

            //Approval
            AppContainer(
              child: AppTextButton(
                onPressed: () {
                  if(user!.role=='varsity'){
                    Navigator.of(context).pushNamed(AppRoutes.adminapproval);
                  }else{
                    Navigator.of(context).pushNamed(AppRoutes.clubApproval);
                  }
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

            //crete club
            //if( user!= null && user.role!='varsity')
            AppContainer(
              child: AppTextButton(
                onPressed: () {
                  if(user!.role=='varsity'){
                    Navigator.of(context).pushNamed(AppRoutes.adminmonitor);
                  }else if(user!.role=='admin'){
                    Navigator.of(context).pushNamed(AppRoutes.createClub);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Need Approval For Creating New Club'),showCloseIcon: true,),
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppURL.create_club_svg,
                          height: 25, width: 25, color: AppColors.icon3),
                      Text(
                          user!.role == 'varsity'
                              ? "  Club Monitoring"
                              : "  Create Your Club",
                          style: AppTexts.button2
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //explore new
            AppContainer(
              child: AppTextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppAllClubViewPage(clubs:clubs),
                    ),
                  );
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

            //personal info edit
            AppContainer(
              child: AppTextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.profileedit);
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
          ],
        ),
      ),
    );
  }


  Future<void> pickFile(String type) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(type=='cover'){
      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            coverImageBytes = bytes;
            coverImageFile = null;
          });
        } else {
          setState(() {
            coverImageFile = File(pickedFile.path);
            coverImageBytes = null;
          });
        }
      }
    }
    else{
      if (pickedFile != null) {
        if (kIsWeb) {
          final bytes = await pickedFile.readAsBytes();
          setState(() {
            imageBytes = bytes;
            imageFile = null;
          });
        } else {
          setState(() {
            imageFile = File(pickedFile.path);
            imageBytes = null;
          });
        }
      }
    }
    uploadImages();
  }

  String? convertToBase64(Uint8List? bytes, File? file) {
    if (bytes != null) {
      return base64Encode(bytes);
    } else if (file != null) {
      return base64Encode(file.readAsBytesSync());
    }
    return null;
  }

  Future<void> uploadImages() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final token = userProvider.token;

    String? base64Profile = convertToBase64(imageBytes, imageFile);
    String? base64Cover = convertToBase64(coverImageBytes, coverImageFile);

    try {
      final response = await http.put(
        Uri.parse('${dotenv.env['API_URL']}/api/updateimage'),
        headers:{
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
      },
        body: jsonEncode({
          '_id': user?.id,
          'profilePicture': base64Profile,
          'coverPicture': base64Cover,
        }),
      );

      if (response.statusCode == 200) {
        print('Images updated');
        final updatedUser = jsonDecode(response.body)['user'];
        userProvider.updateUserFromJson(updatedUser);
        setState(() {});
      } else {
        print('Upload failed: ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}