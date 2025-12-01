import 'package:flutter/material.dart';
import '../services/auth_service.dart';
// Import the screens we will create next
import 'scan_allergy_screen.dart';
import 'nutritional_input_screen.dart';
import 'upload_lab_screen.dart';
import 'sign_in_screen.dart'; // Needed for sign out navigation

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  // Define the structure for each menu optionr
  final List<Map<String, dynamic>> menuItems = const [
    {
      'title': 'Scan for Allergies',
      'icon': Icons.qr_code_scanner,
      'color': Colors.redAccent,
      // Placeholder navigation function
      'onTap': ScanAllergyScreen(),
    },
    {
      'title': 'Enter Nutritional Values',
      'icon': Icons.food_bank,
      'color': Colors.green,
      'onTap': NutritionalInputScreen(),
    },
    {
      'title': 'Upload Lab Results',
      'icon': Icons.file_upload,
      'color': Colors.blue,
      'onTap': UploadLabScreen(),
    },
    {
      'title': 'Sign Out', // We use this spot for sign out instead of sign in
      'icon': Icons.logout,
      'color': Colors.grey,
      'isSignOut': true, // Special flag for sign out
      'onTap': null, // Sign out handled separately
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Companion Hub'),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two tiles per row
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.2, // Make tiles slightly taller than wide
          ),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return _buildMenuItem(context, item);
          },
        ),
      ),
    );
  }

  // Helper method to build each interactive card (tile)
  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        // Use InkWell for better visual feedback on tap
        borderRadius: BorderRadius.circular(15),
        onTap: () async {
          if (item['isSignOut'] == true) {
            // Handle Sign Out logic
            await AuthService().signOut();
            // Navigate back to the SignInScreen after signing out
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                (Route<dynamic> route) => false,
              );
            }
          } else {
            // Handle navigation to other screens
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => item['onTap'] as Widget),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: item['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                item['icon'] as IconData,
                size: 50.0,
                color: item['color'] as Color,
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item['title'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: item['color'] as Color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
