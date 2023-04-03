import 'dart:async';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thesis/models/course_model.dart';

class StorageService {
  //static const _coursesBoxName = 'coursesBox';

  static Future<void> initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
  }

  static Future<void> saveToken(String token) async {
    final box = await Hive.openBox('authBox');
    await box.put('token', token);
  }

  static Future<String?> getToken() async {
    final box = await Hive.openBox('authBox');
    return box.get('token');
  }

  static Future<void> deleteToken() async {
    final box = await Hive.openBox('authBox');
    await box.delete('token');
  }

  static Future<void> saveCourses(List<Course> courses) async {
    final box = await Hive.openBox('coursesBox');
    final List<Map<String, dynamic>> coursesJson =
        courses.map((course) => course.toJson()).toList();
    await box.put('courses', coursesJson);
    await box.close();
  }

  static Future<List<Course>?> getCourses() async {
    final box = await Hive.openBox('coursesBox');
    final List<Map<String, dynamic>>? coursesJson =
        box.get('courses')?.cast<Map<String, dynamic>>();
    await box.close();

    if (coursesJson != null) {
      return coursesJson
          .map((courseJson) => Course.fromJson(courseJson))
          .toList();
    }
    return null;
  }

  static Future<void> saveCurrentCourse(Course course) async {
    final box = await Hive.openBox('courseBox');
    await box.put('currentCourse', course.toJson());
    await box.close();
  }

  static Future<Course?> getCurrentCourse() async {
    final box = await Hive.openBox('courseBox');
    final Map<String, dynamic>? courseJson =
        box.get('currentCourse')?.cast<String, dynamic>();
    await box.close();

    if (courseJson != null) {
      return Course.fromJson(courseJson);
    }

    return null;
  }
}
