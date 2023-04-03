import 'package:hive/hive.dart';

part 'course_model.g.dart';

@HiveType(typeId: 0)
class Course {
  @HiveField(0)
  final String courseId;

  @HiveField(1)
  final String courseName;

  @HiveField(2)
  final String fromLanguage;

  @HiveField(3)
  final String learningLanguage;

  Course({
    required this.courseId,
    required this.courseName,
    required this.fromLanguage,
    required this.learningLanguage,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['course_id'],
      courseName: json['course_name'],
      fromLanguage: json['from_language'],
      learningLanguage: json['learning_language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course_id': courseId,
      'course_name': courseName,
      'from_language': fromLanguage,
      'learning_language': learningLanguage,
    };
  }
}
