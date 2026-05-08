class PharmacistModel {
  final int authID,id;
   String name;
  final String email;
   String phone;
   String imageUrl;

  PharmacistModel({required this.authID,required this.id,required this.name, required this.email, required this.phone,required this.imageUrl});

  factory PharmacistModel.fromJson(Map<String,dynamic> json) => PharmacistModel(
        authID: json['id'] ?? 0,
        name: json['name'] ?? "",
        email: json['email'] ?? "",
        phone: json['phone'] ?? "",
        imageUrl: json['pharmacist']['image_url'] ?? "",
        id: json['pharmacist']['id'] ?? 0,
      );
}