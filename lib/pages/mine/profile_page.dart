import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/user_info.dart';
import '../../../store/global.dart';
import 'components/avatar.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  UserInfo? userInfo;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  void _loadUserInfo() {
    final globalProvider = Provider.of<GlobalState>(context, listen: false);
    setState(() {
      userInfo = globalProvider.userInfo ?? UserInfo(
        username: 'lirh',
        weight: 125,
        height: 170,
        age: 26,
        gender: 'male',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 80),
              const Avatar(src: 'https://cdn.pixabay.com/photo/2023/06/23/11/23/ai-generated-8083323_640.jpg'),
              const SizedBox(height: 16),
              Text(
                userInfo?.username ?? '',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Edit Profile'),
                onTap: () {
                  // Navigate to Edit Profile page
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Change Password'),
                onTap: () {
                  // Navigate to Change Password page
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  // Navigate to Settings page
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  // Handle logout
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
