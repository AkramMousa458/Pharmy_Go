class PharmacyModel {
  final int id;
  final int pharmacistId;
  final String pharmacyName;
  final double longitude;
  final double latitude;
  final int delivery;
  final DateTime createdAt;
  final DateTime updatedAt;

  PharmacyModel({
    required this.id,
    required this.pharmacistId,
    required this.pharmacyName,
    required this.delivery,
    required this.longitude,
    required this.latitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      id: json['id'] ?? 0,
      pharmacistId: json['pharmacist_id'] ?? 0,
      pharmacyName: json['pharmacy_name'] ?? "",
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      delivery: json['delivery'] ?? 0,
      createdAt: DateTime.parse(
          json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}
