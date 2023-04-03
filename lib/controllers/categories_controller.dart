import 'package:thesis/models/category_model.dart';
import 'package:thesis/services/api_service.dart';

class CategoriesController {
  final ApiService _apiService;
  List<Category> categories = [];

  CategoriesController(this._apiService);

  Future<List<Category>> fetchCategories(String token, String courseId) async {
    final response = await _apiService.getCategories(token, courseId);
    return response.map((json) => Category.fromJson(json)).toList();
  }

  Future<void> initialize(String token, String courseId) async {
    categories = await fetchCategories(token, courseId);
  }
}
