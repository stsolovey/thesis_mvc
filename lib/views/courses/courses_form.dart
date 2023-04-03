import 'package:flutter/material.dart';
import 'package:thesis/models/course_model.dart';

typedef CourseTappedCallback = void Function(Course course);

class CoursesForm extends StatelessWidget {
  final List<Course> courses;
  final CourseTappedCallback onCourseTapped;

  const CoursesForm(
      {super.key, required this.courses, required this.onCourseTapped});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {
        final course = courses[index];
        return ListTile(
          title: Text(course.courseName),
          subtitle: Text('${course.fromLanguage} - ${course.learningLanguage}'),
          onTap: () => onCourseTapped(course),
        );
      },
    );
  }
}
