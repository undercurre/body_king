import 'package:body_king/router/index.dart';
import 'package:body_king/utils/global.dart';
import 'package:body_king/utils/storage.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  // 确保 Flutter 绑定被初始化
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  await GlobalManager().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: GlobalManager().token == null ? '/login' : '/',
      routes: AppRoutes.routes,
    );
  }
}
