import 'package:flutter/material.dart';

class homepages extends StatelessWidget {
  const homepages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ClubNest App"),),
      body: Center(
        child: Text("Welcome to ClubNest"),
      ),
    );
  }
}
