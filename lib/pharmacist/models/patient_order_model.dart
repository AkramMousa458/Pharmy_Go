class PatientOrderModel {
  final int id;
  final String name;
  final String email;
  final String address;
  final String phone;
  final String imageUrl;

  PatientOrderModel(
      {
      required this.id,
      required this.name,
      required this.email,
      required this.address,
      required this.phone,
      required this.imageUrl});

  factory PatientOrderModel.fromJson(Map<String, dynamic> json) =>
      PatientOrderModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        email: json['email'] ?? "",
        address: json['address'] ?? "",
        phone: json['phone'] ?? "",
        imageUrl: json['image_url'] ?? "",
      );
}
