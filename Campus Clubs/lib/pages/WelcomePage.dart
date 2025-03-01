import 'dart:convert';
import 'package:campusclubs/components/NavigateSlide.dart';
import 'package:campusclubs/config/AppRoutes.dart';
import 'package:campusclubs/config/AppString.dart';
import 'package:campusclubs/styles/AppTexts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../styles/AppColors.dart';

class WelcomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  List<Map<String, dynamic>> _pageContents = [];

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/data/top_page.json');
    setState(() {
      _pageContents = List<Map<String, dynamic>>.from(json.decode(jsonString));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageContents.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pageContents.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            _pageContents[index]['imagePath'],
                            height: 250,
                          ),
                          SizedBox(height: 70),
                          Text(
                            _pageContents[index]['title'],
                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _pageContents[index]['description'],
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pageContents.length, (index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index ? AppColors.rediobutton1 : AppColors.rediobutton2,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.login);
                },
                child: Text(AppString.join, style: AppTexts.button),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
          if (currentPage < _pageContents.length - 1)
            NavigateSlide(
            isRight: true,
            onPressed: () {
              if (currentPage < _pageContents.length - 1) {
                setState(() {
                  currentPage++;
                });
                _pageController.animateToPage(
                  currentPage,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
          if (currentPage > 0)
          NavigateSlide(
            isRight: false,
            onPressed: () {
              if (currentPage > 0) {
                setState(() {
                  currentPage--;
                });
                _pageController.animateToPage(
                  currentPage,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}