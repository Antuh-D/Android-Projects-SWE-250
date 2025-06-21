import 'dart:convert';
import 'package:campusclubs/config/AppRoutes.dart';
import 'package:http/http.dart' as http;

import 'package:campusclubs/components/AppTextField.dart';
import 'package:campusclubs/components/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import '../config/AppString.dart';
import '../config/AppURL.dart';
import '../styles/AppColors.dart';
import '../styles/AppTexts.dart';


class AppClubApprovalPage extends StatefulWidget {
  const AppClubApprovalPage({super.key});

  @override
  State<AppClubApprovalPage> createState() => _AppClubApprovalPageState();
}

class _AppClubApprovalPageState extends State<AppClubApprovalPage> {
  final TextEditingController clubname = TextEditingController();
  final TextEditingController contract = TextEditingController();
  final TextEditingController applicationText = TextEditingController();
  final TextEditingController president = TextEditingController();
  String? category;

  final catagorylist = ["Tech", "Culture", "Sports", "Science", "Education", "Health", "Business", "Art", "Music", "Gaming", "Travel", "Environment", "Food", "History"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        Headding: AppString.clubApproval,
        backpage: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            //Theme and Heading
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

            Divider(thickness: 1,),


            //Application form
            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: AppTextField(hint: "Club Name", controller: clubname ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: AppTextField(hint: "Contact No", controller: contract),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
              child: Text(
                "Write your application to request varsity authority approval for creating a new club.",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,),
              child: TextField(
                controller: applicationText,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: "Type your application...",
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
                    fillColor:Colors.white.withOpacity(0.9),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: DropdownButtonFormField(
                items: catagorylist
                    .map((c) => DropdownMenuItem(
                    value: c,
                    child: Text(c,))).toList(),
                    onChanged: (value) {
                      setState(() {
                         category = value;
                      });
                     },
                  decoration: InputDecoration(labelText: "Club Category",
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
                  fillColor:Colors.white.withOpacity(0.9),

                ),
                dropdownColor: Colors.white,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 20),
              child: AppTextField(hint: "Club President", controller: president),
            ),

            //submit
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () async {
                  final bool x = await submission();
                  if (x) {
                    Navigator.of(context).pushReplacementNamed(AppRoutes.profile);
                  }
                },
                child: Text("Submit",style: AppTexts.button,),
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

  Future<bool> submission() async {
    if (clubname.text.isEmpty || contract.text.isEmpty || applicationText.text.isEmpty || category == null || president.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
      return false;
    }

    final application = {
      "clubname": clubname.text.trim(),
      "contract": contract.text.trim(),
      "applicationText": applicationText.text.trim(),
      "category": category,
      "president": president.text.trim(),
    };

    try {
      final url = Uri.parse('${dotenv.env['API_URL']}/api/approval');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(application),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Submitted successfully')),
        );
        return true;
      } else if (response.statusCode == 409) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('This Club already exists')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Submission failed: ${response.statusCode}')),
        );
      }
    } catch (e) {
      print("Submission error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Submission error: $e')),
      );
    }
    return false;
  }
}
