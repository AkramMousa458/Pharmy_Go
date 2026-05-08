import 'package:pharmygo/public/models/drug_model.dart';

class ItemOrderModel {
  final int id;
  final int quantity;
  final double price;
  final DrugModel drug;

  ItemOrderModel({
    required this.id,
    required this.quantity,
    required this.price,
    required this.drug,
  });

  factory ItemOrderModel.fromJson(Map<String, dynamic> json) => ItemOrderModel(
        id: json['id'] ?? 0,
        quantity: json['quantity'] ?? 0,
        price: (json['price'] is int)
            ? (json['price'] as int).toDouble()
            : (json['price'] is double)
                ? json['price']
                : double.parse(json['price']),
        drug: DrugModel.fromJson(json['drug']),
      );
}
