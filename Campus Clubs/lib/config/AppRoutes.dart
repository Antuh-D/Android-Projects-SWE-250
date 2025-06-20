import 'package:flutter/material.dart';
import 'package:campusclubs/pages/AppClubApprovalPage.dart';
import 'package:campusclubs/pages/AppClubViewPage.dart';
import 'package:campusclubs/pages/AppProfileEditPage.dart';
import 'package:campusclubs/pages/ClosedEventsPage.dart';
import 'package:campusclubs/pages/MenuPage.dart';
import 'package:campusclubs/pages/MyClubPage.dart';
import 'package:campusclubs/pages/ProfilePage.dart';
import 'package:campusclubs/pages/SearchPage.dart';
import 'package:campusclubs/pages/UpcomingEventsPage.dart';

import '../pages/AppCreateClubPage.dart';
import '../pages/HomePage.dart';
import '../pages/SingUpPage.dart';
import '../pages/LoginPage.dart';
import '../pages/WelcomePage.dart';

class AppRoutes {
  static final pages = {
    welcomepage: (context) => WelcomePage(),
    login: (context) => LoginPage(),
    signup: (context) => SignUpPage(),
    home: (context) => HomePage(),
    myclubs: (context) => MyClubPage(),
    menus: (context) => MenuPage(),
    search: (context) => SearchPage(),
    profile: (context) => ProfilePage(),
    clubApproval: (context) => AppClubApprovalPage(),
    profileedit: (context) => AppProfileEditPage(),
    createClub: (context) => AppCreateClubPage(),

    // Updated routes for events pages - no arguments needed
    upcomingEventsPage: (context) => UpcomingEventsPage(),
    closedEventsPage: (context) => ClosedEventsPage(),
  };

  // Route names
  static const welcomepage = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const menus = '/menus';
  static const search = '/search';
  static const profile = '/profile';
  static const myclubs = '/clubs';
  static const clubApproval = '/apply';
  static const profileedit = '/infoEdit';
  static const createClub = '/createclub';
  static const upcomingEventsPage = '/upcoming-events';
  static const closedEventsPage = '/closed-events';
}
