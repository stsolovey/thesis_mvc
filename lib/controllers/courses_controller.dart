import 'package:thesis/models/course_model.dart';
import 'package:thesis/services/api_service.dart';
import 'package:thesis/services/storage_serivce.dart';

class CoursesController {
  final ApiService apiService;

  CoursesController(this.apiService);

  Future<List<Course>> fetchCourses() async {
    final token = await StorageService.getToken();
    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await apiService.getCourses(token);
    if (response['status']) {
      final courses = List<Course>.from(
        response['message'].map((courseJson) => Course.fromJson(courseJson)),
      );
      await StorageService.saveCourses(courses);
      return courses;
    } else {
      throw Exception('Failed to fetch courses');
    }
  }
}
