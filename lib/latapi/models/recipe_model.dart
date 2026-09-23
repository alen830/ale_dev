class RecipeModel {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final String area;
  final String instructions;

  RecipeModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.area,
    required this.instructions,
  });

  // Factory constructor untuk mapping data dari JSON API (TheMealDB)
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? 'Tanpa Nama',
      imageUrl: json['strMealThumb'] ?? '',
      category: json['strCategory'] ?? 'Umum',
      area: json['strArea'] ?? 'Internasional',
      instructions: json['strInstructions'] ?? 'Tidak ada petunjuk.',
    );
  }
}
