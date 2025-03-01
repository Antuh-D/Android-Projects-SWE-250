import 'package:campusclubs/components/MyAppBar.dart';
import 'package:campusclubs/config/AppRoutes.dart';
import 'package:campusclubs/config/AppString.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import '../config/AppURL.dart';
import '../config/UserProvider.dart';


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    final String? profilePicture = user?.profilePicture;
    final String baseUrl = (profilePicture != null && profilePicture.isNotEmpty)
        ? dotenv.env['API_URL']! + profilePicture
        : '';

    return Scaffold(
      appBar: MyAppBar(
        Headding: AppString.appname,
        onProfileClick:(){
          Navigator.of(context).pushNamed(AppRoutes.profile);
        },
        onSettingsClick:(){

        },
      ),
      body: SingleChildScrollView(
        child: Center(
          child: user == null
              ? Text("No user logged in")
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              baseUrl.isNotEmpty?
              Image.network(baseUrl):Image.asset(AppURL.email_logo),
              Text("Welcome, ${user.name}!"),
              Text("Email: ${user.email}"),
            ],
          ),
        ),
      ),
    );
  }
}