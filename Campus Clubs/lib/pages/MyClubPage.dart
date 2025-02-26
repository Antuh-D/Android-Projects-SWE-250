import 'package:campusclubs/components/MyAppBar.dart';
import 'package:campusclubs/config/AppRoutes.dart';
import 'package:campusclubs/config/AppString.dart';
import 'package:flutter/material.dart';

class MyClubPage extends StatefulWidget {
  const MyClubPage({super.key});

  @override
  State<MyClubPage> createState() => _MyClubPageState();
}

class _MyClubPageState extends State<MyClubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onProfileClick: (){
          Navigator.of(context).pushNamed(AppRoutes.profile);
        },
        Headding: AppString.myclubs,
      ),
      body: Center(child: Text('Your Joined clubs ')),
    );
  }
}
