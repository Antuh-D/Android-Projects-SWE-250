
import 'package:campusclubs/pages/MenuPage.dart';
import 'package:campusclubs/pages/SearchPage.dart';

import '../pages/HomePage.dart';
import '../pages/SingUpPage.dart';
import '../pages/LoginPage.dart';
import '../pages/WelcomePage.dart';

class AppRoutes{
  static final pages ={
    welcomepage : (context)=> WelcomePage(),
    login: (context) => LoginPage(),
    signup: (context)=> SignUpPage(),
    home:(context) => HomePage(),
    menus: (context) => MenuPage(),
    search: (context) => SearchPage(),
  };
  static const welcomepage = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const menus = '/menus';
  static const search = '/search';
}