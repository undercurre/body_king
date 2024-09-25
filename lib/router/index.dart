// app_routes.dart

import 'package:flutter/material.dart';

import '../pages/home_page.dart';
import '../pages/login_page.dart';

class AppRoutes {

  static Map<String, WidgetBuilder> get routes {
    return {
      '/': (context) => const HomePage(),
      '/login': (context) => const LoginPage(),
      '/home': (context) => const HomePage()
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
