class DonationModel {
  final String nameOfMedcine;
  final String address;
  final String quantityOfMedcine;

  DonationModel({
    required this.nameOfMedcine,
    required this.address,
    required this.quantityOfMedcine,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) =>
      DonationModel(
        nameOfMedcine: json['drug_name'] ?? '',
        address: json['address'] ?? "",
        quantityOfMedcine: json['quantity'] ?? "0",
      );

  Map<String, dynamic> toJson() {
    return {
      'drug_name': nameOfMedcine,
      'address': address,
      'quantity': quantityOfMedcine,
    };
  }
}