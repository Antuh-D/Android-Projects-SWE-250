import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../components/AppTextField.dart';
import '../config/AppRoutes.dart';
import '../config/AppString.dart';
import '../config/AppURL.dart';
import '../config/UserProvider.dart';
import '../styles/AppColors.dart';
import '../styles/AppTexts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class LoginCredentials {
  final String email;
  final String password;

  LoginCredentials({required this.email, required this.password});
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';
  final String _loginUrl = "${dotenv.env['API_URL']}/api/login";

  Future<void> login() async {
    final credentials = LoginCredentials(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (credentials.email.isEmpty || credentials.password.isEmpty) {
      showError("Please fill in all fields.");
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(_loginUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": credentials.email, "password": credentials.password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setToken(data['token']);
        await userProvider.fetchUserByEmail(credentials.email);
        Navigator.pushNamed(context, AppRoutes.menus);
      } else {
        showError(data['message'] ?? "Login failed");
      }
    } catch (_) {
      showError("An error occurred. Please try again.");
    } finally {
      setState(() => isLoading = false);
    }
  }

  void showError(String message) {
    setState(() => errorMessage = message);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _socialButton({required String imagePath, required String text, VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          elevation: 5,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, height: 35),
            const SizedBox(width: 10),
            Text(text, style: AppTexts.normalbold),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Column(
      children: [
        Text(AppString.welcomeText1, style: AppTexts.AppHeading),
        const SizedBox(height: 10),
        Text(AppString.welcomeText2, style: AppTexts.grayText),
        const SizedBox(height: 10),
        AppTextField(hint: 'Email', controller: emailController),
        const SizedBox(height: 10),
        AppTextField(hint: 'Password', controller: passwordController, obscureText: true),
        const SizedBox(height: 20),
        SizedBox(
          width: 250,
          height: 40,
          child: ElevatedButton(
            onPressed: isLoading ? null : login,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buttonColor,
              elevation: 5,
            ),
            child: const Text("LOGIN", style: AppTexts.button2),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(AppURL.loginTheme, height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppURL.mens_icon, height: 30, width: 30, color: Colors.black),
                Text(AppString.appname, style: AppTexts.AppHeading),
              ],
            ),
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white.withOpacity(0.3)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2))],
              ),
              padding: const EdgeInsets.all(20),
              child: _loginForm(),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => debugPrint("Forget password button pressed"),
                child: const Text("Forget Password ?", style: TextStyle(color: Colors.blueAccent)),
              ),
            ),
            const Text("Or sign in with", style: AppTexts.normal),
            const SizedBox(height: 5),
            _socialButton(imagePath: AppURL.fblogo, text: "Login with Facebook", onPressed: () {}),
            _socialButton(imagePath: AppURL.googlelogo, text: "Sign with Google", onPressed: () {}),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?", style: AppTexts.normal),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed(AppRoutes.signup),
                  child: const Text("Sign up", style: AppTexts.normalbule),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
