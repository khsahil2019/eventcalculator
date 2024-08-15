class EquipmentRequest {
  String userId;
  Map<String, int> equipmentQuantities;

  EquipmentRequest({required this.userId, required this.equipmentQuantities});
}

class VendorEstimate {
  String vendorId;
  Map<String, double> equipmentPrices; // Price per unit
  double totalPrice;

  VendorEstimate({
    required this.vendorId,
    required this.equipmentPrices,
    required this.totalPrice,
  });
}
