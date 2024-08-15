// lib/main.dart
import 'package:flutter/material.dart';
import 'package:practice/screens/equipment_request_screen.dart';

void main() {
  runApp(EquipmentOrderingApp());
}

class EquipmentOrderingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Equipment Ordering App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EquipmentRequestScreen(),
    );
  }
}
