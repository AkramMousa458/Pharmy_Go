import 'package:pharmygo/pharmacist/models/custom_order_model.dart';
import 'package:pharmygo/pharmacist/models/patient_order_model.dart';

class PharmacyOrderModel {
  final PatientOrderModel patient;
  final List<CustomOrderModel> orders;

  PharmacyOrderModel({
    required this.patient,
    required this.orders,
  });

  factory PharmacyOrderModel.fromJson(Map<String, dynamic> json) =>
      PharmacyOrderModel(
        patient: PatientOrderModel.fromJson(json['patient']),
        orders: (json['orders'] as List)
            .map((item) => CustomOrderModel.fromJson(item))
            .toList(),
      );
}
