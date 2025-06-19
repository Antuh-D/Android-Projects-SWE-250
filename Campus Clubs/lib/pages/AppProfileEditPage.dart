import 'package:campusclubs/components/MyAppBar.dart';
import 'package:campusclubs/config/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/AppTextField.dart';
import '../config/UserProvider.dart';
import '../styles/AppColors.dart';
import '../styles/AppTexts.dart';

class AppProfileEditPage extends StatefulWidget {
  const AppProfileEditPage({super.key});

  @override
  State<AppProfileEditPage> createState() => _AppProfileEditPageState();
}

class _AppProfileEditPageState extends State<AppProfileEditPage> {
  TextEditingController  username = TextEditingController();
  TextEditingController  registration = TextEditingController();
  TextEditingController  passwordold = TextEditingController();
  TextEditingController  passwordnew = TextEditingController();
  TextEditingController  department = TextEditingController();
  TextEditingController  university = TextEditingController();

  final String url = "${dotenv.env['API_URL']}/api/updateprofile";

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      username.text = user.name;
      registration.text = user.registation;
      department.text = user.department;
      university.text = user.university;
    }
  }


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    //print(user);

    return Scaffold(
      appBar: MyAppBar(
        Headding: "Personal info",
      ),
      body: Center(
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
              padding: const EdgeInsets.only(top: 30,left: 15,right: 15,bottom: 20),
              child: Column(
                children: [
                  AppTextField(hint: 'Username', controller: username,),
                  SizedBox(height: 14,),
                  AppTextField(hint: 'Registration', controller: registration,),
                  SizedBox(height: 14,),
                  AppTextField(hint: 'Old Password', controller: passwordold,),
                  SizedBox(height: 14,),
                  AppTextField(hint: 'New Password', controller: passwordnew,),
                  SizedBox(height: 14,),
                  AppTextField(hint: 'Department Name', controller: department,),
                  SizedBox(height: 14,),
                  AppTextField(hint: 'University Name', controller: university,),
                  SizedBox(height: 14,),
                  Padding(
                   padding: EdgeInsets.all(16),
                   child: ElevatedButton(
                   onPressed: () {
                    submission();
                   },
                   child: Text("Submit",style: AppTexts.button,),
                   style: ElevatedButton.styleFrom(backgroundColor: AppColors.buttonColor,),
                   ),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submission() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final token = userProvider.token;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not found")),
      );
      return;
    }

    final Map<String, dynamic> updateFields = {
      "_id": user.id, // Ensure _id is included
    };

    if (username.text.trim() != user.name) {
      updateFields["username"] = username.text.trim();
    }
    if (registration.text.trim() != user.registation) {
      updateFields["registration"] = registration.text.trim();
    }
    if (department.text.trim() != user.department) {
      updateFields["department"] = department.text.trim();
    }
    if (university.text.trim() != user.university) {
      updateFields["university"] = university.text.trim();
    }

    if (passwordold.text.isNotEmpty && passwordnew.text.isNotEmpty) {
      updateFields["oldPassword"] = passwordold.text;
      updateFields["newPassword"] = passwordnew.text;
    }

    if (updateFields.length == 1) { // Only _id present
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No changes to update")),
      );
      return;
    }

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(updateFields),
      );

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final updatedUserJson = result["user"];
        if (updatedUserJson != null) {
          userProvider.updateUserFromJson(updatedUserJson);
        }

        Navigator.of(context).pushReplacementNamed(AppRoutes.profile);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile updated successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result["error"] ?? "Update failed")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }


}