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
      userInfo = globalProvider.userInfo ??
          UserInfo(
            username: 'lirh',
            weight: 125,
            height: 170,
            age: 26,
            gender: 'male',
          );
    });
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Perform logout operation
                GlobalState().clear();
                Navigator.of(context).pop(); // Close the dialog
                // Add your logout logic here
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
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
              Avatar(src: context.watch<GlobalState>().avatar_url),
              const SizedBox(height: 16),
              Text(
                userInfo?.username ?? '',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              // ListTile(
              //   leading: const Icon(Icons.person),
              //   title: const Text('Edit Profile'),
              //   onTap: () {
              //     // Navigate to Edit Profile page
              //   },
              // ),
              // ListTile(
              //   leading: const Icon(Icons.lock),
              //   title: const Text('Change Password'),
              //   onTap: () {
              //     // Navigate to Change Password page
              //   },
              // ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  // Navigate to Settings page
                  Navigator.pushNamed(context, '/setting');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: _confirmLogout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
