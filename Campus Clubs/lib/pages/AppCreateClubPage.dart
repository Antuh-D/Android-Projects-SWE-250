import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../components/AppTextField.dart';
import '../components/MyAppBar.dart';
import '../config/AppString.dart';
import '../config/AppURL.dart';
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
  String? category;

  Uint8List? imageBytes;
  File? imageFile;

  Uint8List? documentBytes;
  File? documentFile;
  String? documentName;

  final ImagePicker picker = ImagePicker();

  String? get documentDisplay {
    if (kIsWeb) {
      return documentName;
    } else {
      return documentFile?.path ?? documentName;
    }
  }

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
            // Theme and Heading
            Center(child: Image.asset(AppURL.loginTheme, height: 150)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppURL.mens_icon,
                  height: 30,
                  width: 30,
                  color: Colors.black,
                ),
                Text(
                  "Your Club",
                  style: AppTexts.AppHeading,
                )
              ],
            ),
            Divider(thickness: 1),
            SizedBox(height: 30),

            // Club name, email
            AppFormField("1. Enter Club Name", name),
            SizedBox(height: 16),
            AppFormField("2. Enter Club Email", email),

            // category
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("3. Select One", style: AppTexts.normal),
                  SizedBox(height: 5),
                  DropdownButtonFormField(
                    items: ["Tech", "Culture", "Sports"]
                        .map(
                          (c) => DropdownMenuItem(
                        value: c,
                        child: Text(c),
                      ),
                    )
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
                        borderSide: BorderSide(
                          color: Colors.black38,
                          width: 2.0,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                    ),
                    dropdownColor: Colors.white,
                  ),
                ],
              ),
            ),

            // subtitle, contract
            AppFormField("4. Write a Subtitle", subtitle, hint: "Related to club goal"),
            SizedBox(height: 16),
            AppFormField("5. Contract No", contract, hint: "with country code"),

            // file input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreateTextButton(
                    labelText: "6. Upload Current Club Committee(pdf,doc,docx)",
                    iconAsset: Icon(Icons.upload_file_rounded, size: 20, color: AppColors.icon2),
                    textStyle: AppTexts.normal,
                    onPressed: () {
                      pickFile('doc');
                    },
                  ),
                  if (documentDisplay != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text("$documentDisplay"),
                    ),

                  SizedBox(height: 16),

                  CreateTextButton(
                    labelText: "7. Upload The Club logo",
                    iconAsset: Icon(Icons.manage_accounts, color: AppColors.icon2, size: 25),
                    textStyle: AppTexts.normal,
                    onPressed: () {
                      pickFile('image');
                    },
                  ),
                  if (imageFile != null) Text("${imageFile!.path}"),
                  if (imageBytes != null) Text("Logo uploaded successfully "),
                ],
              ),
            ),

            // submit button
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  
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

  Future<void> pickFile(String type) async {
    if (type == 'image') {
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
    } else if (type == 'doc') {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      if (result != null &&
          (result.files.single.bytes != null || result.files.single.path != null)) {
        final file = result.files.single;

        setState(() {
          documentName = file.name;
          documentBytes = file.bytes;

          if (kIsWeb) {
            // On web, do NOT create File instance
            documentFile = null;
          } else {
            // On mobile/desktop, create File instance if path exists
            documentFile = file.path != null ? File(file.path!) : null;
          }
        });
      }
    }
  }
}
