
import 'package:campusclubs/pages/SingUpPage.dart';

import '../pages/LoginPage.dart';
import '../pages/WelcomePage.dart';

class AppRoutes{
  static final pages ={
    welcomepage : (context)=> WelcomePage(),
    login: (context) => LoginPage(),
    signup: (context)=> SignUpPage(),
  };
  static const welcomepage = '/';
  static const login = '/login';
  static const signup = '/signup';
}