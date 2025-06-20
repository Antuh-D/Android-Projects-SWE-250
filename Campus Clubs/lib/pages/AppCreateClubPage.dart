import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:campusclubs/pages/AppClubViewPage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../components/AppTextField.dart';
import '../components/MyAppBar.dart';
import '../config/AppString.dart';
import '../config/AppURL.dart';
import '../config/ClubModel.dart';
import '../styles/AppColors.dart';
import '../styles/AppTexts.dart';

class AppCreateClubPage extends StatefulWidget {
  const AppCreateClubPage({super.key});

  @override
  State<AppCreateClubPage> createState() => _AppCreateClubPageState();
}

class _AppCreateClubPageState extends State<AppCreateClubPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController contract = TextEditingController();
  final TextEditingController subtitle = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController facebookLink = TextEditingController();
  final TextEditingController president = TextEditingController();
  final TextEditingController vicePresident = TextEditingController();
  String? category;

  Uint8List? imageBytes;
  File? imageFile;

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        Headding: AppString.createClub,
        backpage: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(AppURL.loginTheme, height: 150)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppURL.mens_icon, height: 30, width: 30, color: Colors.black),
                Text("Your Club", style: AppTexts.AppHeading),
              ],
            ),
            Divider(thickness: 1),
            SizedBox(height: 30),
            AppFormField("1. Enter Club Name", name),
            SizedBox(height: 16),
            AppFormField("2. Enter Club Email", email),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("3. Select One", style: AppTexts.normal),
                  SizedBox(height: 5),
                  DropdownButtonFormField(
                    items: ["Tech", "Culture", "Sports"]
                        .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        category = value as String?;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Club Category",
                      labelStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.black38, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                    ),
                    dropdownColor: Colors.white,
                  ),
                ],
              ),
            ),

            AppFormField("4. Write a Subtitle", subtitle, hint: "Related to club goal"),
            SizedBox(height: 16),
            AppFormField("5. Contract No", contract, hint: "with country code"),
            SizedBox(height: 16),
            AppFormField("6. Club Description", description, hint: "What is your club about"),
            SizedBox(height: 16),
            AppFormField("7. Facebook Page URL", facebookLink),
            SizedBox(height: 16),
            AppFormField("8. Club President", president),
            SizedBox(height: 16),
            AppFormField("9. Vice President", vicePresident),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateTextButton(
                    labelText: "10. Upload The Club logo",
                    iconAsset: Icon(Icons.manage_accounts, color: AppColors.icon2, size: 25),
                    textStyle: AppTexts.normal,
                    onPressed: () {
                      pickFile();
                    },
                  ),
                  if (imageFile != null) Text("${imageFile!.path}"),
                  if (imageBytes != null) Text("Logo uploaded successfully (Web)"),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  if (category == null || category!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a category')),
                    );
                    return;
                  }

                  String? base64Image;
                  if (imageBytes != null) {
                    base64Image = base64Encode(imageBytes!);
                  }

                  final newClub = {
                    "name": name.text.trim(),
                    "subtitle": subtitle.text.trim(),
                    "description": description.text.trim(),
                    "email": email.text.trim(),
                    "phone": contract.text.trim(),
                    "category": category,
                    "facebookLink": facebookLink.text.trim(),
                    "president": president.text.trim(),
                    "vicePresident": vicePresident.text.trim(),
                    "createdAt": DateTime.now().toIso8601String(),
                    "isApproved": false,
                    "followers": 0,
                    "members": 0,
                    "image": base64Image ?? "",
                  };

                  bool success = await submitClub(newClub);

                  if (success) {
                    final ClubModel createdClub = ClubModel.fromJson(newClub);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppClubViewPage(club: createdClub),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to create club')),
                    );
                  }
                },
                child: Text("Submit", style: AppTexts.button),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget AppFormField(String label, TextEditingController controller, {String hint = ""}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTexts.normal),
          AppTextField(hint: hint, controller: controller),
        ],
      ),
    );
  }

  Widget CreateTextButton({
    required VoidCallback onPressed,
    required String labelText,
    required Widget iconAsset,
    required TextStyle textStyle,
  }) {
    return Row(
      children: [
        Flexible(child: Text("$labelText           ", style: textStyle)),
        TextButton(
          onPressed: onPressed,
          child: iconAsset,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            minimumSize: MaterialStateProperty.all(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }

  Future<void> pickFile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
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

  Future<bool> submitClub(Map<String, dynamic> clubData) async {
    final url = Uri.parse('${dotenv.env['API_URL']}/api/club');

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(clubData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print("Failed to submit club: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error submitting club: $e");
      return false;
    }
  }
}
