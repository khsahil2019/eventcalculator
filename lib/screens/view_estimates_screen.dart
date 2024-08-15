import 'package:flutter/material.dart';
import 'package:practice/models/models.dart';

class ViewEstimatesScreen extends StatelessWidget {
  final List<VendorEstimate> estimates;

  ViewEstimatesScreen({required this.estimates});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendors Estimates'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: estimates.length,
          itemBuilder: (context, index) {
            final estimate = estimates[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16.0),
                leading: const Icon(
                  Icons.business,
                  color: Colors.teal,
                  size: 40,
                ),
                title: Text(
                  'Vendor: ${estimate.vendorId}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...estimate.equipmentPrices.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '${entry.key}: \$${entry.value.toStringAsFixed(2)} per unit',
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 8.0),
                    Text(
                      'Total: \$${estimate.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Handle selection logic here
                    print('Selected estimate from ${estimate.vendorId}');
                  },
                  child: const Text('Select'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
