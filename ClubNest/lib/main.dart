import 'package:clubnest/firebase_options.dart';
import 'package:clubnest/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  String apiKey = dotenv.env['FIREBASE_API_KEY']!;

  print("Firebase API Key: $apiKey");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white54,
      ),
      initialRoute:'/',
      routes: {
        '/': (context) => const homepages(),
      },
    );
  }
}


