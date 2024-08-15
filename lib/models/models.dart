// lib/models/models.dart
class Equipment {
  final String name;
  final double hourlyRate;
  final double dailyRate;

  Equipment({
    required this.name,
    required this.hourlyRate,
    required this.dailyRate,
  });
}

class VendorEstimate {
  final String vendorId;
  final Map<String, double> equipmentPrices; // Per unit price
  final double totalEstimate;

  VendorEstimate({
    required this.vendorId,
    required this.equipmentPrices,
    required this.totalEstimate,
  });
}

class EquipmentRequest {
  final String userId;
  final Map<String, EquipmentQuantity> equipmentQuantities;

  EquipmentRequest({
    required this.userId,
    required this.equipmentQuantities,
  });
}

class EquipmentQuantity {
  final int quantity;
  final int hours;
  final int days;

  EquipmentQuantity({
    required this.quantity,
    required this.hours,
    required this.days,
  });

  EquipmentQuantity copyWith({
    int? quantity,
    int? hours,
    int? days,
  }) {
    return EquipmentQuantity(
      quantity: quantity ?? this.quantity,
      hours: hours ?? this.hours,
      days: days ?? this.days,
    );
  }

  double calculateTotal(double hourlyRate, double dailyRate) {
    return (hours * hourlyRate + days * dailyRate) * quantity;
  }
}
