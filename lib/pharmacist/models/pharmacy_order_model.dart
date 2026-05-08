import 'package:pharmygo/pharmacist/models/pharmacy_model.dart';
import 'package:pharmygo/public/models/item_order_model.dart';

class PharmacyOrderModel {
  final int id;
  final int patientId;
  final int totalAmount;
  final PharmacyModel pharmacy;
  final List<ItemOrderModel> items;

  PharmacyOrderModel({
    required this.id,
    required this.patientId,
    required this.totalAmount,
    required this.pharmacy,
    required this.items,
  });

  factory PharmacyOrderModel.fromJson(Map<String, dynamic> json) =>
      PharmacyOrderModel(
        id: json['id'] ?? 0,
        patientId: json['patient_id'] ?? 0,
        totalAmount: json['total_amount'] ?? 0,
        pharmacy: PharmacyModel.fromJson(json['pharmacy']),
        items: (json['items'] as List)
            .map((item) => ItemOrderModel.fromJson(item))
            .toList(),
      );
}
