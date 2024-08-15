import 'package:flutter/material.dart';
import 'package:practice/backend.dart';
import 'package:practice/models/models.dart';

class ViewEstimatesScreen extends StatelessWidget {
  final Map<String, EquipmentQuantity> selectedEquipment;

  ViewEstimatesScreen({required this.selectedEquipment});

  @override
  Widget build(BuildContext context) {
    final estimates = _calculateEstimates();

    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Estimates'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: estimates.length,
        itemBuilder: (context, index) {
          final estimate = estimates[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Text('Vendor: ${estimate.vendorId}'),
              subtitle: Text(
                'Total Estimate: \$${estimate.totalEstimate.toStringAsFixed(2)}',
              ),
              children: estimate.equipmentPrices.entries.map((entry) {
                final equipmentName = entry.key;
                final price = entry.value;
                final quantity = selectedEquipment[equipmentName]!;
                final isHourly = MockBackend.availableHourlyEquipment
                    .any((e) => e.name == equipmentName);

                return ListTile(
                  title: Text(
                    '$equipmentName (${isHourly ? "Hourly" : "Daily"})',
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${quantity.quantity}'),
                      if (isHourly) Text('Hours: ${quantity.hours}'),
                      if (!isHourly) Text('Days: ${quantity.days}'),
                      Text(
                        'Rate: \$${price.toStringAsFixed(2)}',
                      ),
                      Text(
                        'Total: \$${quantity.calculateTotal(
                              isHourly ? price : 0.0,
                              isHourly ? 0.0 : price,
                            ).toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  List<VendorEstimate> _calculateEstimates() {
    List<VendorEstimate> estimates = [];

    for (var vendor in MockBackend.vendorPrices.entries) {
      double total = 0.0;
      Map<String, double> equipmentPrices = {};

      for (var equipment in selectedEquipment.entries) {
        final equipmentName = equipment.key;
        final quantity = equipment.value;
        final price = vendor.value[equipmentName] ?? 0.0;

        // Determine if the equipment is hourly or daily
        bool isHourly = MockBackend.availableHourlyEquipment
            .any((e) => e.name == equipmentName);

        double hourlyRate = isHourly ? price : 0.0;
        double dailyRate = isHourly ? 0.0 : price;

        double itemTotal = quantity.calculateTotal(hourlyRate, dailyRate);
        equipmentPrices[equipmentName] = price;
        total += itemTotal;
      }

      estimates.add(VendorEstimate(
        vendorId: vendor.key,
        equipmentPrices: equipmentPrices,
        totalEstimate: total,
      ));
    }

    return estimates;
  }
}
