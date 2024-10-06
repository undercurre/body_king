import 'package:body_king/store/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: context.watch<GlobalState>().isDarkMode,
                onChanged: (value) {
                  context.read<GlobalState>().toggleDarkMode();
                },
              ),
              const SizedBox(height: 20),
              // Text(
              //   'Language',
              //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // ),
              // ListTile(
              //   title: Text('English'),
              //   onTap: () {
              //     context.read<AppState>().setLocale(Locale('en'));
              //   },
              // ),
              // ListTile(
              //   title: Text('Spanish'),
              //   onTap: () {
              //     context.read<AppState>().setLocale(Locale('es'));
              //   },
              // ),
              // ListTile(
              //   title: Text('Chinese'),
              //   onTap: () {
              //     context.read<AppState>().setLocale(Locale('zh'));
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
