class PatientModel {
  final int authID,id;
   String name;
  final String email;
   String phone;
   String imageUrl;

  PatientModel( {required this.authID,required this.name,required this.id,required this.email, required this.phone,required this.imageUrl});

  factory PatientModel.fromJson(Map<String,dynamic> json) => PatientModel(
        authID: json['id'] ?? 0,
        name: json['name'] ?? "",
        email: json['email'] ?? "",
        phone: json['phone'] ?? "",
        imageUrl: json['patient']['image_url'] ?? "",
        id: json['patient']['id'] ?? 0,
      );
}

