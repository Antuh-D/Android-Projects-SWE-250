
import '../pages/LoginPage.dart';
import '../pages/WelcomePage.dart';

class AppRoutes{
  static final pages ={
    welcomepage : (context)=> WelcomePage(),
    login: (context) => LoginPage(),
  };
  static const welcomepage = '/';
  static const login = '/login';
}