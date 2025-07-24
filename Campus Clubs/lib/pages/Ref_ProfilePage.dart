import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../styles/AppTexts.dart';


enum UserRole { admin, varsity, general }

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final String userName = 'Md. Shakil Mia';
  final String email = 'shakilmia1133@gmail.com';
  final UserRole role = UserRole.varsity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          _buildProfileHeader(),
          const SizedBox(height: 20),
          _buildUserInfo(),
          const SizedBox(height: 30),
          _buildRoleBasedMenu(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/profile_image.png'),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.edit, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        Text(userName, style: AppTexts.normalbold),
        const SizedBox(height: 5),
        Text(email, style: AppTexts.normalbold),
      ],
    );
  }

  Widget _buildRoleBasedMenu(BuildContext context) {
    switch (role) {
      case UserRole.admin:
        return Column(
          children: [
            _buildMenuItem('assets/icons/manage_club.svg', 'Manage Clubs', () {}),
            _buildMenuItem('assets/icons/add_event.svg', 'Add Event', () {}),
          ],
        );
      case UserRole.varsity:
        return _buildMenuItem('assets/icons/my_club.svg', 'My Club', () {});
      case UserRole.general:
      default:
        return _buildMenuItem('assets/icons/joined_club.svg', 'Joined Clubs', () {});
    }
  }

  Widget _buildMenuItem(String iconPath, String title, VoidCallback onTap) {
    return ListTile(
      leading: SvgPicture.asset(iconPath, height: 28),
      title: Text(title, style: AppTexts.normal),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}