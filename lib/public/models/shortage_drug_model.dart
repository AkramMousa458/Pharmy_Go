import 'package:pharmygo/pharmacist/models/pharmacy_model.dart';
import 'package:pharmygo/public/models/drug_model.dart';

class ShortageDrugModel {
  final int pharmacyDrugId;
  final PharmacyModel pharmacy;
  final DrugModel drug;
  final int quantity;

  ShortageDrugModel({
    required this.pharmacyDrugId,
    required this.pharmacy,
    required this.drug,
    required this.quantity,
  });

  factory ShortageDrugModel.fromJson(Map<String, dynamic> json) =>
      ShortageDrugModel(
        pharmacyDrugId: json['pharmacy_drug_id'] ?? 0,
        pharmacy: PharmacyModel.fromJson(json['pharmacy']),
        drug: DrugModel.fromJson(json['drug']),
        quantity: json['quantity'],
      );
}
