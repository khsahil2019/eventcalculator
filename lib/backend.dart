import 'package:practice/models/models.dart';

class MockBackend {
  // Equipment available with hourly and daily rates
  static List<Equipment> availableHourlyEquipment = [
    Equipment(name: 'Projector', hourlyRate: 15.0, dailyRate: 0.0),
    Equipment(
        name: 'Camera',
        hourlyRate: 30.0,
        dailyRate: 0.0), // Additional equipment
    Equipment(
        name: 'Laptop',
        hourlyRate: 15.0,
        dailyRate: 0.0), // Additional equipment
  ];

  static List<Equipment> availableDailyEquipment = [
    Equipment(name: 'Stage', hourlyRate: 0.0, dailyRate: 500.0),
    Equipment(
        name: 'Audience chairs non cushioned',
        hourlyRate: 0.0,
        dailyRate: 10.0),
    Equipment(
        name: 'Audience chairs cushioned', hourlyRate: 0.0, dailyRate: 20.0),
    Equipment(name: 'VIP Chairs', hourlyRate: 0.0, dailyRate: 50.0),
    Equipment(name: 'Sofa', hourlyRate: 0.0, dailyRate: 150.0),
    Equipment(name: 'Deepak Stand', hourlyRate: 0.0, dailyRate: 25.0),
    Equipment(name: 'Center table', hourlyRate: 0.0, dailyRate: 30.0),
    Equipment(name: 'Rectangle table', hourlyRate: 0.0, dailyRate: 40.0),
    Equipment(name: 'Round tables', hourlyRate: 0.0, dailyRate: 35.0),
    Equipment(name: 'Flowers', hourlyRate: 0.0, dailyRate: 15.0),
    Equipment(
        name: 'Flowerpots with flowers', hourlyRate: 0.0, dailyRate: 12.0),
    Equipment(name: 'Flower decoration', hourlyRate: 0.0, dailyRate: 25.0),
    Equipment(name: 'Bokeh', hourlyRate: 0.0, dailyRate: 20.0),
    Equipment(name: 'Wrapped roses', hourlyRate: 0.0, dailyRate: 18.0),
    Equipment(name: 'Flowers bunch', hourlyRate: 0.0, dailyRate: 22.0),
    Equipment(name: 'Red carpet', hourlyRate: 0.0, dailyRate: 100.0),
    Equipment(name: 'Floor carpet', hourlyRate: 0.0, dailyRate: 80.0),
    Equipment(name: 'Transport (Goods)', hourlyRate: 0.0, dailyRate: 250.0),
    Equipment(name: 'Transport (Passenger)', hourlyRate: 0.0, dailyRate: 300.0),
  ];

  // Vendor prices for the equipment (assuming the price is per unit)
  static Map<String, Map<String, double>> vendorPrices = {
    'vendor_1': {
      'Projector': 15.0,
      'Camera': 30.0,
      'Laptop': 15.0,
      'Stage': 500.0,
      'Audience chairs non cushioned': 10.0,
      'Audience chairs cushioned': 20.0,
      'VIP Chairs': 50.0,
      'Sofa': 150.0,
      'Deepak Stand': 25.0,
      'Center table': 30.0,
      'Rectangle table': 40.0,
      'Round tables': 35.0,
      'Flowers': 15.0,
      'Flowerpots with flowers': 12.0,
      'Flower decoration': 25.0,
      'Bokeh': 20.0,
      'Wrapped roses': 18.0,
      'Flowers bunch': 22.0,
      'Red carpet': 100.0,
      'Floor carpet': 80.0,
      'Transport (Goods)': 250.0,
      'Transport (Passenger)': 300.0,
    },
    'vendor_2': {
      'Projector': 18.0, // Different pricing
      'Camera': 35.0,
      'Laptop': 20.0,
      'Stage': 550.0,
      'Audience chairs non cushioned': 12.0,
      'Audience chairs cushioned': 25.0,
      'VIP Chairs': 55.0,
      'Sofa': 160.0,
      'Deepak Stand': 30.0,
      'Center table': 35.0,
      'Rectangle table': 45.0,
      'Round tables': 40.0,
      'Flowers': 18.0,
      'Flowerpots with flowers': 15.0,
      'Flower decoration': 28.0,
      'Bokeh': 22.0,
      'Wrapped roses': 20.0,
      'Flowers bunch': 25.0,
      'Red carpet': 110.0,
      'Floor carpet': 90.0,
      'Transport (Goods)': 270.0,
      'Transport (Passenger)': 320.0,
    },
    'vendor_3': {
      'Projector': 12.0, // Different pricing
      'Camera': 28.0,
      'Laptop': 12.0,
      'Stage': 480.0,
      'Audience chairs non cushioned': 8.0,
      'Audience chairs cushioned': 18.0,
      'VIP Chairs': 45.0,
      'Sofa': 140.0,
      'Deepak Stand': 22.0,
      'Center table': 28.0,
      'Rectangle table': 38.0,
      'Round tables': 33.0,
      'Flowers': 12.0,
      'Flowerpots with flowers': 10.0,
      'Flower decoration': 20.0,
      'Bokeh': 18.0,
      'Wrapped roses': 16.0,
      'Flowers bunch': 20.0,
      'Red carpet': 90.0,
      'Floor carpet': 70.0,
      'Transport (Goods)': 240.0,
      'Transport (Passenger)': 290.0,
    },
  };
}
