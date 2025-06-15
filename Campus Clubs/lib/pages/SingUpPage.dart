import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:campusclubs/config/AppString.dart';
import 'package:campusclubs/config/AppURL.dart';
import 'package:campusclubs/styles/AppColors.dart';
import 'package:campusclubs/styles/AppTexts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/AppTextField.dart';
import '../config/AppRoutes.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<SignUpPage> {
  final TextEditingController username = TextEditingController();
  final TextEditingController  email = TextEditingController();
  final TextEditingController  registration = TextEditingController();
  final TextEditingController  password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  bool isLoading = false;

  Future<void> signUp() async{
    if (password.text != confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse("${dotenv.env['API_URL']}/api/signup"), // Change to your backend API
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username.text,
        'email': email.text,
        'registration': registration.text,
        'password': password.text,
      }),
    );

    setState(() {
      isLoading = false;
    });

    print("Response Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 201) {
      Navigator.of(context).pushNamed(AppRoutes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to sign up')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(AppURL.loginTheme, height: 150),
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
                    AppString.appname,
                    style: AppTexts.AppHeading,
                  )
                ],
              ),
              SizedBox(height: 50,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(AppString.signup, style: AppTexts.AppHeading),
                      SizedBox(height: 10,),
                      SvgPicture.asset(AppURL.user,height: 40,),
                      SizedBox(height:5),
                      Text(AppString.undersingup, style: AppTexts.normal),
                      SizedBox(height: 20),
                      AppTextField(hint: 'Username', controller: username,),
                      SizedBox(height: 10),
                      AppTextField(hint: 'Email', controller: email,),
                      SizedBox(height: 10),
                      AppTextField(hint: 'Registation No', controller: registration),
                      SizedBox(height: 10),
                      AppTextField(hint: 'Password', controller: password,obscureText: true,),
                      SizedBox(height: 10),
                      AppTextField(hint: 'Confirm Password', controller: confirmPassword, obscureText: true,),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                             signUp();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonColor,
                            elevation: 5,
                          ),
                          child:isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : const Text(
                            "SIGN UP",
                            style: AppTexts.button2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              const Text("Or", style:AppTexts.normal),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(7),
                child: ElevatedButton(
                  onPressed: () {
                    print("Login with Facebook button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    elevation: 5,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Ensures it wraps the content size
                    children: [
                      Image.asset(
                        AppURL.email_logo,
                        height: 25, // Adjust height as needed
                      ),
                      SizedBox(width: 10), // Add spacing between image and text
                      const Text("Continue with Email",style: AppTexts.normalbold,)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    elevation: 5,
                  ),
                  child:  Row(
                    mainAxisSize: MainAxisSize.min, // Ensures it wraps the content size
                    children: [
                      Image.asset(
                        AppURL.googlelogo,
                        height: 35, // Adjust height as needed
                      ),
                      SizedBox(width: 10), // Add spacing between image and text
                      const Text("Continue with Google",style: AppTexts.normalbold)
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?", style: AppTexts.normal),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.login);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                    ),
                    child: const Text(
                      "Login",
                      style: AppTexts.normalbule,

                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
