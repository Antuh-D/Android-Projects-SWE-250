import 'dart:convert';

import 'package:campusclubs/config/AppRoutes.dart';
import 'package:campusclubs/config/AppString.dart';
import 'package:campusclubs/config/AppURL.dart';
import 'package:campusclubs/styles/AppColors.dart';
import 'package:campusclubs/styles/AppTexts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../components/AppTextField.dart';
import 'package:http/http.dart' as http;

import '../config/UserProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isLoading = false;
  String  errorMessage='';
  // Add the backend login URL
  final String _loginUrl = "${dotenv.env['API_URL']}/api/login";  // <-- Replace with your backend URL

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    final String emailValue = email.text.trim();  // Get the email text
    final String passwordValue = password.text.trim();  // Get the password text

    // Basic validation to check if fields are empty
    if (emailValue.isEmpty || passwordValue.isEmpty) {
      setState(() {
        isLoading = false;
        errorMessage = "Please fill in all fields."; // Error message if fields are empty
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": emailValue, "password": passwordValue}),  // Use the text values here
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Provider.of<UserProvider>(context, listen: false).fetchUserByEmail(emailValue);
        Navigator.pushNamed(context, AppRoutes.menus);  // Navigate to Home page
      } else {
        setState(() {
          errorMessage = responseData['message'] ?? "Login failed";  // Display backend error message
        });
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(errorMessage)),
     );
      }
    } catch (e) {
      setState(() {
        errorMessage = "An error occurred. Please try again.";  // Handle network errors
      });
    } finally {
      setState(() {
        isLoading = false;  // Stop loading indicator
      });
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
              SizedBox(height: 50),
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
                      Text(AppString.welcomeText1, style: AppTexts.AppHeading),
                      SizedBox(height: 10),
                      Text(AppString.welcomeText2, style: AppTexts.grayText),
                      SizedBox(height: 10),
                      AppTextField(hint: 'Email', controller: email),
                      SizedBox(height: 10),
                      AppTextField(hint: 'Password', controller: password, obscureText: true),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!isLoading) {
                              login(); // <-- Call the login function properly
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonColor,
                            elevation: 5,
                          ),
                          child: const Text(
                            "LOGIN",
                            style: AppTexts.button2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    print("Forget password button pressed");
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey,
                  ),
                  child: const Text("Forget Password ?", style: TextStyle(color: Colors.blueAccent)),
                ),
              ),
              const Text("Or sign in with", style: AppTexts.normal),
              SizedBox(height: 5),
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
                        AppURL.fblogo,
                        height: 35, // Adjust height as needed
                      ),
                      SizedBox(width: 10), // Add spacing between image and text
                      const Text("Login with Facebook", style: AppTexts.normalbold)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: ElevatedButton(
                  onPressed: () {},
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
                        AppURL.googlelogo,
                        height: 35, // Adjust height as needed
                      ),
                      SizedBox(width: 10), // Add spacing between image and text
                      const Text("Sign with Google", style: AppTexts.normalbold)
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?", style: AppTexts.normal),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.signup);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                    ),
                    child: const Text(
                      "Sign up",
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
