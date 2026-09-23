import 'package:ale_dev/tugas14/models/drink_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  final String _url =
      'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=a'; // Mengambil daftar minuman diawali huruf A

  Future<List<DrinkModel>> fetchDrinks() async {
    try {
      final response = await _dio.get(_url);

      if (response.statusCode == 200) {
        final List drinksData = response.data['drinks'] ?? [];
        return drinksData.map((json) => DrinkModel.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data dari server');
      }
    } on DioException catch (e) {
      throw Exception('Kesalahan koneksi: ${e.message}');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
