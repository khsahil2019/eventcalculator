// lib/screens/equipment_request_screen.dart
import 'package:flutter/material.dart';
import 'package:practice/backend.dart';
import 'package:practice/widgets/equipment_selection_widget.dart';
import 'package:practice/screens/view_estimates_screen.dart';
import 'package:practice/models/models.dart';

class EquipmentRequestScreen extends StatefulWidget {
  @override
  _EquipmentRequestScreenState createState() => _EquipmentRequestScreenState();
}

class _EquipmentRequestScreenState extends State<EquipmentRequestScreen> {
  Map<String, EquipmentQuantity> selectedEquipment = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipment Order'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EquipmentSelectionWidget(
              hourlyEquipmentOptions: MockBackend.availableHourlyEquipment,
              dailyEquipmentOptions: MockBackend.availableDailyEquipment,
              selectedEquipment: selectedEquipment,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewEstimatesScreen(
                        selectedEquipment: selectedEquipment),
                  ),
                );
              },
              child: Text('View Estimates'),
            ),
          ],
        ),
      ),
    );
  }
}
