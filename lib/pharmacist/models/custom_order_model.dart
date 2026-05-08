import 'package:pharmygo/public/models/item_order_model.dart';

class CustomOrderModel {
  final int id;
  final int pharmacyId;
  final double totalAmount;
  final int finished;
  final List<ItemOrderModel> items;

  CustomOrderModel({
    required this.id,
    required this.pharmacyId,
    required this.totalAmount,
    required this.finished,
    required this.items,
  });

  factory CustomOrderModel.fromJson(Map<String, dynamic> json) => CustomOrderModel(
        id: json['id'] ?? 0,
        pharmacyId: json['pharmacy_id'] ?? 0,
        totalAmount: (json['total_amount'] is int)
            ? (json['total_amount'] as int).toDouble()
            : (json['total_amount'] is double)
                ? json['total_amount']
                : double.parse(json['total_amount']),
        finished: json['finished'] ?? 0,
        items: (json['items'] as List)
            .map((item) => ItemOrderModel.fromJson(item))
            .toList(),
      );
}
