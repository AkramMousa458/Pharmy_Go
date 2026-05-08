class DrugModel {
  final int id;
  final String nameEn;
  final String nameAr;
  final double price;
  final String imageUrl;

  DrugModel(
      {required this.id,
      required this.nameEn,
      required this.nameAr,
      required this.price,
      required this.imageUrl});

  factory DrugModel.fromJson(Map<String, dynamic> json) => DrugModel(
        id: json['id'] ?? 0,
        nameEn: json['name_en'] ?? "",
        nameAr: json['name_ar'] ?? json['name_en'],
        price: (json['price'] is int)
            ? (json['price'] as int).toDouble()
            : (json['price'] is double)
                ? json['price']
                : double.parse(json['price']),
        imageUrl: json['image_url'] ?? "",
      );
}
