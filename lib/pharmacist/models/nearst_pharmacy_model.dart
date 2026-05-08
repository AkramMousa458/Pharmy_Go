class NearestPharmacyModel {
  final int id;
  final String pharmacist;
  final String pharmacyName;
  final double longitude;
  final double latitude;
  final double distance;
  final int delivery;
  final int quantity;

  NearestPharmacyModel({
    required this.id,
    required this.pharmacist,
    required this.pharmacyName,
    required this.longitude,
    required this.latitude,
    required this.distance,
    required this.delivery,
    required this.quantity,
  });

  factory NearestPharmacyModel.fromJson(Map<String, dynamic> json) {
    return NearestPharmacyModel(

      id: json['pharmacy_id'] ?? 0,
      pharmacist: json['pharmacist'] ?? "",
      pharmacyName: json['name'] ?? "",
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      distance: (json['distance'] ?? 0.0).toDouble(),
      delivery: json['delivery'] ?? 0,
      quantity: json['quantity'] ?? 0,
    );
  }

  static List<NearestPharmacyModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NearestPharmacyModel.fromJson(json)).toList();
  }
}
