import 'package:flutter/material.dart';
import 'package:practice/backend.dart';
import 'package:practice/models/models.dart';

class TicketPricingScreen extends StatefulWidget {
  final String vendorId;
  final List<VendorEstimate> estimates;

  TicketPricingScreen({required this.vendorId, required this.estimates});

  @override
  _TicketPricingScreenState createState() => _TicketPricingScreenState();
}

class _TicketPricingScreenState extends State<TicketPricingScreen> {
  final TextEditingController _ticketPriceController = TextEditingController();
  final TextEditingController _totalTicketsController = TextEditingController();
  double? _profitLoss;
  double? _totalRevenue;
  double? _totalCost;
  bool _isFreeEvent = false;

  @override
  Widget build(BuildContext context) {
    final selectedEstimate = widget.estimates.firstWhere(
      (estimate) => estimate.vendorId == widget.vendorId,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Pricing'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVendorInfo(),
            SizedBox(height: 20.0),
            _buildEventOptions(),
            if (!_isFreeEvent) ...[
              SizedBox(height: 20.0),
              _buildTicketPriceField(),
              SizedBox(height: 20.0),
              _buildTotalTicketsField(),
            ],
            SizedBox(height: 20.0),
            _buildActionButton(),
            if (!_isFreeEvent && _profitLoss != null) ...[
              SizedBox(height: 20.0),
              _buildCalculationDetails(),
              SizedBox(height: 20.0),
              _buildCreateEventButton(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildVendorInfo() {
    return Text(
      'Vendor: ${widget.vendorId}',
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
    );
  }

  Widget _buildEventOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: ListTile(
            title: Text('Make Event Free'),
            leading: Radio<bool>(
              value: true,
              groupValue: _isFreeEvent,
              onChanged: (value) {
                setState(() {
                  _isFreeEvent = value ?? false;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: ListTile(
            title: Text('Sell Tickets'),
            leading: Radio<bool>(
              value: false,
              groupValue: _isFreeEvent,
              onChanged: (value) {
                setState(() {
                  _isFreeEvent = value ?? true;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTicketPriceField() {
    return TextField(
      controller: _ticketPriceController,
      decoration: InputDecoration(
        labelText: 'Ticket Price',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildTotalTicketsField() {
    return TextField(
      controller: _totalTicketsController,
      decoration: InputDecoration(
        labelText: 'Total Tickets Sold',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton(
      onPressed: _isFreeEvent ? _createEvent : _calculateProfitLoss,
      child: Text(_isFreeEvent ? 'Create Event' : 'Calculate Profit/Loss'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCalculationDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calculation Details:',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        SizedBox(height: 10.0),
        _buildDetailRow('Ticket Price', '\$${_ticketPriceController.text}'),
        _buildDetailRow(
            'Total Tickets Sold', '${_totalTicketsController.text}'),
        _buildDetailRow(
            'Total Revenue', '\$${_totalRevenue!.toStringAsFixed(2)}'),
        _buildDetailRow('Total Cost', '\$${_totalCost!.toStringAsFixed(2)}'),
        _buildDetailRow(
            'Estimated Profit/Loss', '\$${_profitLoss!.toStringAsFixed(2)}',
            isBold: true),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        '$label: $value',
        style: TextStyle(
          fontSize: 16,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildCreateEventButton() {
    return ElevatedButton(
      onPressed: _createEvent,
      child: Text('Create Event'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _calculateProfitLoss() {
    final ticketPrice = double.tryParse(_ticketPriceController.text) ?? 0.0;
    final totalTickets = int.tryParse(_totalTicketsController.text) ?? 0;

    final selectedEstimate = widget.estimates.firstWhere(
      (estimate) => estimate.vendorId == widget.vendorId,
    );

    final totalRevenue = ticketPrice * totalTickets;
    final totalCost = selectedEstimate.totalEstimate;
    final profitLoss = totalRevenue - totalCost;

    setState(() {
      _profitLoss = profitLoss;
      _totalRevenue = totalRevenue;
      _totalCost = totalCost;
    });
  }

  void _createEvent() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Event Created'),
        content: Text('Your event has been created successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to the previous screen
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
