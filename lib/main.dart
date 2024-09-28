import 'package:body_king/router/index.dart';
import 'package:body_king/store/global.dart';
import 'package:body_king/store/workout.dart';
import 'package:body_king/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // 确保 Flutter 绑定被初始化
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  final globalState = GlobalState();
  await globalState.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WorkoutProvider()),
        ChangeNotifierProvider(create: (context) => GlobalState()),
      ],
      child: const MyApp(),
    ),
  );
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
      initialRoute: '/splash',
      routes: AppRoutes.routes,
    );
  }
}
