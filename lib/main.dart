import 'package:body_king/router/index.dart';
import 'package:body_king/store/global.dart';
import 'package:body_king/store/workout.dart';
import 'package:body_king/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        ChangeNotifierProvider(create: (context) => globalState),
      ],
      child: const MyApp(),
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: MyApp.navigatorKey,
      // 将 navigatorKey 传递给 MaterialApp
      title: 'Recipe App',
      theme: context.watch<GlobalState>().isDarkMode ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/splash',
      routes: AppRoutes.routes,
    );
  }
}
