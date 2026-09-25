import 'package:ale_dev/latapi/models/recipe_model.dart';
import 'package:ale_dev/latapi/services/api_service.dart' show ApiService;
import 'package:flutter/material.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  late Future<List<RecipeModel>> _futureRecipes;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _futureRecipes = _apiService.fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍳 Recipes DB - Abuzar'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<RecipeModel>>(
        future: _futureRecipes,
        builder: (context, snapshot) {
          // 1. Loading Indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Error Handling
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 60,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${snapshot.error}'.replaceAll('Exception: ', ''),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadData,
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          // 3. Jika Data Kosong
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Data resep tidak ditemukan.'));
          }

          // 4. Menampilkan Data dengan Card, Row, dan Column
          final recipes = snapshot.data!;
          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    // Navigasi ke Detail Page (Bonus)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            _RecipeDetailScreen(recipe: recipe),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Gambar di Samping Teks
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            recipe.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.broken_image),
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Teks di Samping Gambar
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Chip(
                                label: Text(recipe.category),
                                padding: EdgeInsets.zero,
                                visualDensity: VisualDensity.compact,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Asal: ${recipe.area}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _RecipeDetailScreen extends StatelessWidget {
  final RecipeModel recipe;

  const _RecipeDetailScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                recipe.imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 220,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.broken_image)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              recipe.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Kategori: ${recipe.category}'),
            Text('Asal: ${recipe.area}'),
          ],
        ),
      ),
    );
  }
}
