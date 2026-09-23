class DrinkModel {
  final String id;
  final String name;
  final String category;
  final String image;

  DrinkModel({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
  });

  // Memetakan data JSON dari API ke model Dart
  factory DrinkModel.fromJson(Map<String, dynamic> json) {
    return DrinkModel(
      id: json['idDrink'] ?? '',
      name: json['strDrink'] ?? 'Tanpa Nama',
      category: json['strCategory'] ?? 'Tanpa Kategori',
      image: json['strDrinkThumb'] ?? '',
    );
  }
}
