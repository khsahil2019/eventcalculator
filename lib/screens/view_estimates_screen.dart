import 'package:flutter/material.dart';
import 'package:practice/backend.dart';
import 'package:practice/models/models.dart';
import 'package:practice/screens/ticket_pricing_screen.dart';

class ViewEstimatesScreen extends StatefulWidget {
  final Map<String, EquipmentQuantity> selectedEquipment;

  ViewEstimatesScreen({required this.selectedEquipment});

  @override
  _ViewEstimatesScreenState createState() => _ViewEstimatesScreenState();
}

class _ViewEstimatesScreenState extends State<ViewEstimatesScreen> {
  String? _selectedVendor;

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
            elevation: 5.0,
            child: ExpansionTile(
              tilePadding: EdgeInsets.all(12.0),
              title: Text(
                'Vendor: ${estimate.vendorId}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Total Estimate: \$${estimate.totalEstimate.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                ),
              ),
              children: estimate.equipmentPrices.entries.map((entry) {
                final equipmentName = entry.key;
                final price = entry.value;
                final quantity = widget.selectedEquipment[equipmentName]!;
                final isHourly = MockBackend.availableHourlyEquipment
                    .any((e) => e.name == equipmentName);

                return ListTile(
                  leading: Icon(
                    isHourly ? Icons.access_time : Icons.calendar_today,
                    color: Colors.teal,
                  ),
                  title: Text(
                    '$equipmentName (${isHourly ? "Hourly" : "Daily"})',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${quantity.quantity}',
                          style: TextStyle(fontSize: 14)),
                      if (isHourly) Text('Hours: ${quantity.hours}'),
                      if (!isHourly) Text('Days: ${quantity.days}'),
                      Text('Rate: \$${price.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 14)),
                      Text(
                        'Total: \$${quantity.calculateTotal(
                              isHourly ? price : 0.0,
                              isHourly ? 0.0 : price,
                            ).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedVendor = estimate.vendorId;
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketPricingScreen(
                        vendorId: _selectedVendor!,
                        estimates: estimates,
                      ),
                    ),
                  );
                },
                child: Text('Select: ${estimate.vendorId}'),
              ),
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

      for (var equipment in widget.selectedEquipment.entries) {
        final equipmentName = equipment.key;
        final quantity = equipment.value;
        final price = vendor.value[equipmentName] ?? 0.0;

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
