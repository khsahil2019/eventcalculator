import 'package:flutter/material.dart';
import 'package:practice/backend.dart';
import 'package:practice/button.dart';
import 'package:practice/models/models.dart';
import 'package:practice/screens/view_estimates_screen.dart';

class VendorEstimateScreen extends StatelessWidget {
  final EquipmentRequest request;

  VendorEstimateScreen({required this.request});

  final Map<String, TextEditingController> priceControllers = {};

  @override
  Widget build(BuildContext context) {
    // Initialize price controllers for each vendor and equipment
    MockBackend.vendorPrices.forEach((vendorId, prices) {
      prices.forEach((equipment, price) {
        priceControllers['$vendorId:$equipment'] =
            TextEditingController(text: price.toString());
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Estimate'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: MockBackend.vendorPrices.keys.map((vendorId) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 12.0),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Vendor: $vendorId',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          ...request.equipmentQuantities.keys.map((equipment) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '$equipment - Qty: ${request.equipmentQuantities[equipment]}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 120,
                                    child: TextFormField(
                                      controller: priceControllers[
                                          '$vendorId:$equipment'],
                                      decoration: InputDecoration(
                                        labelText: 'Price per unit',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16.0),
            GradientElevatedButton(
              onPressed: () {
                _submitEstimates(context);
              },
              text: 'Submit Estimates',
            ),
          ],
        ),
      ),
    );
  }

  void _submitEstimates(BuildContext context) {
    final estimates = <VendorEstimate>[];

    MockBackend.vendorPrices.forEach((vendorId, prices) {
      double totalPrice = 0.0;
      Map<String, double> equipmentPrices = {};

      request.equipmentQuantities.forEach((equipment, quantity) {
        final price = double.tryParse(
                priceControllers['$vendorId:$equipment']?.text ?? '0') ??
            0.0;
        equipmentPrices[equipment] = price;
        totalPrice += price * quantity;
      });

      estimates.add(VendorEstimate(
        vendorId: vendorId,
        equipmentPrices: equipmentPrices,
        totalPrice: totalPrice,
      ));
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewEstimatesScreen(estimates: estimates),
      ),
    );
  }
}
