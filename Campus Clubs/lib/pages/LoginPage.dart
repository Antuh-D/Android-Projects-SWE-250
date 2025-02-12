import 'package:campusclubs/config/AppString.dart';
import 'package:campusclubs/config/AppURL.dart';
import 'package:campusclubs/styles/AppColors.dart';
import 'package:campusclubs/styles/AppTexts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/AppTextField.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                      Text(AppString.welcomeText1, style: AppTexts.AppHeading),
                      SizedBox(height: 10),
                      Text(AppString.welcomeText2, style: AppTexts.grayText),
                      SizedBox(height: 10),
                      AppTextField(hint: 'UserName'),
                      SizedBox(height: 10),
                      AppTextField(hint: 'Registation No'),
                      SizedBox(height: 10),
                      AppTextField(hint: 'Password'),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 250,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {},
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
                    foregroundColor: Colors.white70,
                  ),
                  child: const Text("Forget Password ?"),
                ),
              ),
              const Text("Or sign in with", style: TextStyle(color: Color(0xffD8D8D8))),
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
                  child: const Text("Login with Facebook"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7),
                child: ElevatedButton(
                  onPressed: () {
                    print("Sign with Google button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    elevation: 5,
                  ),
                  child: const Text("Sign with Google"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?", style: TextStyle(color: Color(0xffD8D8D8))),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Color(0xffFBD512)),
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
