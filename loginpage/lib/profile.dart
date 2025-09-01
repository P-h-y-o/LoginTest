// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loginpage/user_model.dart';
import 'package:loginpage/user_singleton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<ProfileScreen> {
  final currentUser = CurrentUserSingleton().currentuser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/img3.jpg'),
            ),
            SizedBox(height: 10),
            Text(
              currentUser!.userName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              currentUser!.email,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildProfileStat('1', 'Posts'),
                buildProfileStat('46', 'Followers'),
                buildProfileStat('144', 'Following'),
              ],
            ),
            SizedBox(height: 20),
            ProfileMenuOption(
              icon: Icons.edit,
              text: 'Edit Profile',
              onTap: () {},
            ),
            ProfileMenuOption(
              icon: Icons.location_on,
              text: 'Addresses',
              onTap: () {},
            ),
            ProfileMenuOption(
              icon: Icons.phone,
              text: currentUser!.phoneNumber,
              onTap: () {},
            ),
            ProfileMenuOption(
              icon: Icons.search_off_outlined,
              text: 'Legal',
              onTap: () {},
            ),
            ProfileMenuOption(
              icon: Icons.logout_outlined,
              text: 'Logout',
              onTap: () async {
                await Hive.box<UserModel>('userBox').delete('currentuser');
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenuOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final int? notificationCount;

  const ProfileMenuOption({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 235, 235, 235),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
        trailing: notificationCount != null
            ? CircleAvatar(
                radius: 12,
                backgroundColor: Colors.red,
                child: Text(
                  notificationCount.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              )
            : Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

Widget buildProfileStat(String count, String label) {
  return Column(
    children: [
      Text(
        count,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      Text(label, style: TextStyle(fontSize: 16, color: Colors.black)),
    ],
  );
}
