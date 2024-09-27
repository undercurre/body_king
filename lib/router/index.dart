// app_routes.dart

import 'package:body_king/pages/main_index.dart';
import 'package:body_king/pages/splash_screen.dart';
import 'package:flutter/material.dart';

import '../pages/login_page.dart';

class AppRoutes {

  static Map<String, WidgetBuilder> get routes {
    return {
      '/': (context) => MainIndex(),
      '/splash': (context) => const SplashScreen(),
      '/login': (context) => const LoginPage(),
      '/home': (context) => MainIndex()
    };
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ERROR: Route not found'),
          ),
        );
      },
    );
  }
}
