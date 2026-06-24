import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:teste_flutter_2/screens/dashboard/dashboard_screen.dart';
import 'screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://caxzwnofigedspzrgmrf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNheHp3bm9maWdlZHNwenJnbXJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODE1OTIwMjcsImV4cCI6MjA5NzE2ODAyN30.UYtopzFznU57B4nHSxgGWK9DsQrXZIXQ64rli6FHlvI',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Jogo da Família', home: const HomeScreen());
  }
}
