import 'package:flutter/material.dart';

class ScanAllergyScreen extends StatelessWidget {
  const ScanAllergyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Food Label')),
      body: const Center(
        child: Text('Feature: OCR Scan for Allergens Coming Soon...'),
      ),
    );
  }
}
