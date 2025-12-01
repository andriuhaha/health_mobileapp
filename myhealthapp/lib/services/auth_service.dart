// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';
import 'firestore_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  // Stream to track the current login state
  Stream<User?> get user => _auth.authStateChanges();

  // --- 1. SIGN UP (Create Account) ---
  Future<UserModel?> signUpWithEmail({
    required String email,
    required String password,
    required Map<String, dynamic> initialPersonalData,
  }) async {
    try {
      // 1. Create user with Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      if (user != null) {
        // 2. Create UserModel with initial data
        UserModel newUser = UserModel(
          uid: user.uid,
          email: user.email!,
          personalData: initialPersonalData,
          nutritionalGoals: {
            'calories': 2000.0,
            'protein': 100.0,
            'sodium': 2300.0,
          },
          allergens: [],
          customAllergens: [],
          lastActive: DateTime.now(),
        );

        // 3. Save the initial profile data to Firestore
        await _firestoreService.setUserData(newUser);
        return newUser;
      }
    } on FirebaseAuthException catch (e) {
      print('Sign Up Error: ${e.message}');
    }
    return null;
  }

  // --- 2. SIGN IN ---
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      print('Sign In Error: ${e.message}');
    }
    return null;
  }

  // --- 3. SIGN OUT ---
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
