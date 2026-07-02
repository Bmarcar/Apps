import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/inicio/splash_screen.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://caxzwnofigedspzrgmrf.supabase.co',
    anonKey: 'sb_publishable_mbJyLd-z7jemw4DeuEykaQ_NHCGSzpl',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Florida',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
