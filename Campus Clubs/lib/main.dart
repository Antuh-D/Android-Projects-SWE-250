import 'package:campusclubs/config/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'pages/WelcomePage.dart';
import 'styles/AppColors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor:AppColors.appBackground,
        ),
        initialRoute: AppRoutes.welcomepage,
        routes: AppRoutes.pages,
    );
  }
}