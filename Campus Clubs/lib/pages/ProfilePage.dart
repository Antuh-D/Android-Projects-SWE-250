import 'dart:io';
import 'package:campusclubs/components/MyAppBar.dart';
import 'package:campusclubs/config/AppString.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:provider/provider.dart';
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

  Future<void> pickImage( String Type) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          if (Type=='profile') {
            imageBytes= bytes;
            imageFile= null;
          } else if (Type =='cover') {
            coverImageBytes = bytes;
            coverImageFile = null;
          }
        });
      } else {
        setState(() {
          if (Type == 'profile') {
             imageFile= File(pickedFile.path);
             imageBytes= null;
          } else if (Type == 'cover') {
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

    var screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;

    return Scaffold(
      appBar: MyAppBar(
        Headding: AppString.profile,
        backpage: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [

            // cover && profile
            Stack(
              children: [
                Stack(
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
                              : AssetImage('assets/png/antu.jpg') as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.camera_alt, color: Colors.red, size: 30),
                              onPressed: (){
                                pickImage('cover');
                              },
                            ),
                            SizedBox(width: screenWidth-100,),
                            IconButton(
                              icon: Icon(Icons.edit_calendar_sharp, color: Colors.red, size: 30),
                              onPressed: (){

                              },
                            ),
                          ],
                        ),
                      )
                    ),
                  ],

                ),
                Positioned(
                  bottom: -20,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: (screenWidth/2)-60),
                    child: Stack(
                      children: [
                        Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
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
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt, color: Colors.red, size: 20),
                            onPressed: (){
                              pickImage('profile');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //others components
            Container(
              width: screenWidth/2,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.1),
                //     offset: const Offset(0, 2),
                //   ),
                // ],
              ),
              child:  Center(
              child: user == null
              ? Text("No user logged in")
              : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Text("${user.name}!"),
                Text("Email: ${user.email}"),
                Text("Registation No: ${user.registation}"),
                Text("Department: Software Engineering"),
                Text("Shahjalal University of Science And Technology, Sylhet.")
              ],
               )
              )
            ),
          ],
        ),
      ),
    );
  }
}
