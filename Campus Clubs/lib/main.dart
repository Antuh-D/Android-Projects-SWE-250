import 'package:campusclubs/config/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'config/ClubProvider.dart';
import 'config/EventProvider.dart';
import 'config/InterestProvider.dart';
import 'config/UserProvider.dart';
import 'pages/WelcomePage.dart';
import 'styles/AppColors.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ClubProvider()),
        ChangeNotifierProvider(create: (_) => InterestProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
      ],
      child: MyApp(),
    ),

  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor:AppColors.appBackground,

        ),
      debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.welcomepage,
        routes: AppRoutes.pages,
    );
  }
}