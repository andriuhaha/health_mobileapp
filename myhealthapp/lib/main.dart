// lib/main.dart (CLEANED UP AND UPDATED)

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
// Import your necessary files
import 'services/auth_service.dart';
import 'screens/main_menu_screen.dart';
import 'screens/sign_in_screen.dart';

void main() async {
  // 1. Ensure WidgetsBinding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 3. Run the application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Companion App',
      theme: ThemeData(
        // Set a clean primary theme color
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // --- The CORE ROUTING Logic ---
      home: StreamBuilder<User?>(
        stream: AuthService().user, // Listen to the Firebase auth state changes
        builder: (context, snapshot) {
          // Show a spinner while the connection is being checked
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Data received: If user is logged in (has data), show Main Menu
          if (snapshot.hasData && snapshot.data != null) {
            return const MainMenuScreen();
          }

          // No user data: Show Sign In screen
          //return const SignInScreen();
          return const MainMenuScreen();
        },
      ),
    );
  }
}

// NOTE: We deleted the MyHomePage and _MyHomePageState classes!
