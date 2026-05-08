class DonationModel {
  final String nameOfMedcine;
  final String address;
  final String quantityOfMedcine;
  final int id;
  factory DonationModel.fromJson(Map<String, dynamic> json) => DonationModel(
        nameOfMedcine: json['drug_name'] ?? '',
        address: json['address'] ?? "",
        quantityOfMedcine: json['quantity'] ?? "0",
        id: json['patient_id'] ?? 0,
      );

  DonationModel(
      {required this.nameOfMedcine,
      required this.address,
      required this.id,
      required this.quantityOfMedcine});
}
