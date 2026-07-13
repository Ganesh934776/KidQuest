import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:kidquest/firebase_options.dart';
import 'package:kidquest/screens/common/splash_screen.dart';

import 'package:kidquest/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const KidQuestApp());
}

class KidQuestApp extends StatelessWidget {
  const KidQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KidQuest',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.light,

      home: const SplashScreen(),
    );
  }
}