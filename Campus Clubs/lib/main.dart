import 'package:campusclubs/config/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'pages/WelcomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: AppRoutes.welcomepage,
        routes: AppRoutes.pages,
    );
  }
}