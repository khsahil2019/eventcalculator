import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:practice/backend.dart';
import 'package:practice/button.dart';
import 'package:practice/models/models.dart';
import 'package:practice/screens/vendor_estimate_screen.dart';

class EquipmentRequestScreen extends StatefulWidget {
  @override
  _EquipmentRequestScreenState createState() => _EquipmentRequestScreenState();
}

class _EquipmentRequestScreenState extends State<EquipmentRequestScreen> {
  bool _equipmentRequired = false;
  Map<String, int> selectedEquipment = {};
  final equipmentOptions = [
    'Podium',
    'Mic and Sound System',
    'Stage',
    'Audience chairs non cushioned',
    'Audience chairs cushioned',
    'VIP Chairs',
    'Sofa',
    'Deepak Stand',
    'Center table',
    'Rectangle table',
    'Round tables',
    'Flowers',
    'Flowerpots with flowers',
    'Flower decoration',
    'Bokeh',
    'Wrapped roses',
    'Flowers bunch',
    'Red carpet',
    'Floor carpet',
    'Transport (Goods)',
    'Transport (Passenger)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Equipment Requirements'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Switch(
                  value: _equipmentRequired,
                  onChanged: (value) {
                    setState(() {
                      _equipmentRequired = value;
                      if (!_equipmentRequired) {
                        selectedEquipment.clear();
                      }
                    });
                  },
                ),
                const SizedBox(width: 8.0),
                const Text('Required Equipment'),
              ],
            ),
            const SizedBox(height: 16.0),
            if (_equipmentRequired)
              Expanded(
                child: ListView(
                  children: equipmentOptions.map((equipment) {
                    final isSelected = selectedEquipment.containsKey(equipment);
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: Checkbox(
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                selectedEquipment[equipment] = 1;
                              } else {
                                selectedEquipment.remove(equipment);
                              }
                            });
                          },
                        ),
                        title: Text(
                          equipment,
                          style: const TextStyle(fontSize: 16),
                        ),
                        subtitle: isSelected
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height:
                                          8.0), // Space between equipment name and TextFormField
                                  SizedBox(
                                    width: 120,
                                    child: TextFormField(
                                      initialValue: selectedEquipment[equipment]
                                          ?.toString(),
                                      decoration: InputDecoration(
                                        labelText: 'Qty',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 8),
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedEquipment[equipment] =
                                              int.tryParse(value) ?? 1;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),
              ),
            const SizedBox(height: 16.0),
            GradientElevatedButton(
              onPressed: () {
                final request = EquipmentRequest(
                  userId: 'user_123', // Placeholder for user ID
                  equipmentQuantities: selectedEquipment,
                );
                MockBackend.userRequests
                    .add(request); // Save request to mock backend
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VendorEstimateScreen(request: request),
                  ),
                );
              },
              text: 'Submit Requirements',
            ),
          ],
        ),
      ),
    );
  }
}
