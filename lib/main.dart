import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/home_screen_new.dart';
import 'screens/login_screen_new.dart';
import 'screens/register_screen_new.dart';
import 'screens/home_screen.dart';
import 'screens/my_car_screen.dart';
import 'screens/map_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/analytics_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, _) {
        return MaterialApp(
          title: 'Volt Guard',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: authProvider.isAuthenticated ? '/home_new' : '/login',
          routes: {
            '/login': (context) => const LoginScreen_new(),
            '/register_new': (context) => const RegisterScreen_new(),
            '/home_new': (context) => const HomeScreen_new(),
            '/home': (context) => const HomeScreen(),
            '/mycar': (context) => const MyCarScreen(),
            '/maps': (context) => const MapScreen(),
            '/dashboard': (context) => const DashboardScreen(),
            '/analytics': (context) => const AnalyticsScreen(),
          },
        );
      },
    );
  }
}
