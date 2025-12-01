class UserModel {
  // Core Data
  final String uid;
  final String email;

  // Personal Profile Data
  final Map<String, dynamic> personalData;

  // Nutritional Targets/Goals
  final Map<String, double> nutritionalGoals;

  // Allergy Data
  final List<String> allergens;
  final List<String> customAllergens;

  // Metadata
  final DateTime lastActive;

  // Constructor
  UserModel({
    required this.uid,
    required this.email,
    required this.personalData,
    required this.nutritionalGoals,
    required this.allergens,
    required this.customAllergens,
    required this.lastActive,
  });

  // Factory Constructor: Converts a Map (from Firestore) into a UserModel object
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      personalData: Map<String, dynamic>.from(map['personalData'] ?? {}),
      nutritionalGoals: Map<String, double>.from(map['nutritionalGoals'] ?? {}),
      allergens: List<String>.from(map['allergens'] ?? []),
      customAllergens: List<String>.from(map['customAllergens'] ?? []),
      // Assuming 'lastActive' is a Firebase Timestamp, we convert it to DateTime
      lastActive: (map['lastActive'] as dynamic).toDate(),
    );
  }

  // toMap Method: Converts the UserModel object into a Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'personalData': personalData,
      'nutritionalGoals': nutritionalGoals,
      'allergens': allergens,
      'customAllergens': customAllergens,
      'lastActive': lastActive,
    };
  }
}
