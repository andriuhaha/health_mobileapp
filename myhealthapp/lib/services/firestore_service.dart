// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart'; // Using the relative path

class FirestoreService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users');

  // Used for saving initial user data during sign-up
  Future<void> setUserData(UserModel user) async {
    await _usersCollection.doc(user.uid).set(user.toMap());
  }

  // Used to retrieve the UserModel for a logged-in user
  Future<UserModel?> getUserData(String uid) async {
    DocumentSnapshot doc = await _usersCollection.doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // We will add more methods here later for lab results, etc.
}
