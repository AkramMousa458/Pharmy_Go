import 'package:pharmygo/pharmacist/models/pharmacy_model.dart';
import 'package:pharmygo/public/models/item_order_model.dart';

class OrderModel {
  final int id;
  final int patientId;
  final double totalAmount;
  final PharmacyModel pharmacy;
  final List<ItemOrderModel> items;

  OrderModel({
    required this.id,
    required this.patientId,
    required this.totalAmount,
    required this.pharmacy,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] ?? 0,
        patientId: json['patient_id'] ?? 0,
        totalAmount: (json['total_amount'] is int)
            ? (json['total_amount'] as int).toDouble()
            : (json['total_amount'] is double)
                ? json['total_amount']
                : double.parse(json['total_amount']),
        pharmacy: PharmacyModel.fromJson(json['pharmacy']),
        items: (json['items'] as List)
            .map((item) => ItemOrderModel.fromJson(item))
            .toList(),
      );
}
