import 'package:ale_dev/latapi/models/recipe_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<RecipeModel>> fetchData() async {
    try {
      final response = await _dio.get(
        'https://www.themealdb.com/api/json/v1/1/search.php?s=Chicken',
      );

      if (response.statusCode == 200) {
        final List meals = response.data['meals'] ?? [];
        return meals.map((json) => RecipeModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data dari server');
      }
    } on DioException catch (e) {
      // Penanganan Error Networking Dio
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw Exception('Koneksi internet terputus atau tidak stabil.');
      } else {
        throw Exception('Terjadi kesalahan jaringan: ${e.message}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan tidak terduga: $e');
    }
  }
}
