import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'screens/common/splash_screen.dart';
import 'theme/app_theme.dart';

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

      // KidQuest Theme
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),

      darkTheme: ThemeData.dark(useMaterial3: true),

      themeMode: ThemeMode.light,

      home: const SplashScreen(),
    );
  }
}