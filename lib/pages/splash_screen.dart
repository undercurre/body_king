import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store/global.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    final globalState = Provider.of<GlobalState>(context, listen: false);
    Navigator.pushReplacementNamed(context, globalState.token == null ? '/login' : '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash_image.png',
            fit: BoxFit.cover,
          ),
          Positioned(child: Padding(padding: const EdgeInsets.all(20),
          child: Image.asset('assets/images/splash_tip.png')))
        ],
      ),
    );
  }
}
