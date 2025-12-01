// lib/screens/sign_in_screen.dart

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'main_menu_screen.dart';
import 'sign_up_screen.dart'; // We will create this next

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool isLoading = false;

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      // Attempt to sign in using the AuthService
      var user = await _auth.signInWithEmail(email, password);

      if (user == null) {
        // Failed sign-in
        setState(() {
          error = 'Invalid email or password.';
          isLoading = false;
        });
      } else {
        // Successful sign-in! Navigate to the main menu
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainMenuScreen()),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: Colors.indigo,
        elevation: 0.0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 50.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // Email Field
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          val!.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val.trim());
                      },
                    ),
                    const SizedBox(height: 20.0),
                    // Password Field
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Password'),
                      obscureText: true,
                      validator: (val) =>
                          val!.length < 6 ? 'Password must be 6+ chars' : null,
                      onChanged: (val) {
                        setState(() => password = val.trim());
                      },
                    ),
                    const SizedBox(height: 20.0),
                    // Sign In Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                      ),
                      onPressed: _signIn,
                      child: const Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    // Error Text
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                    // Navigate to Sign Up
                    TextButton(
                      child: const Text('Need an account? Sign Up'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
