import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:kidquest/firebase_options.dart';
import 'package:kidquest/screens/common/role_selection_screen.dart';
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

      // Theme
      theme: AppTheme.lightTheme,

      // Future-ready (Dark Mode)
      darkTheme: ThemeData.dark(useMaterial3: true),

      // Currently always uses light theme
      themeMode: ThemeMode.light,

      // First Screen
      home: const RoleSelectionScreen(),
    );
  }
}