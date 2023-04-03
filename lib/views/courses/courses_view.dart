import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thesis/controllers/courses_controller.dart';
import 'package:thesis/models/course_model.dart';
import 'package:thesis/services/storage_serivce.dart';
import 'package:thesis/views/courses/courses_form.dart';
import 'package:thesis/routes.dart';

typedef LogoutCallback = void Function();

class CoursesView extends StatefulWidget {
  final CoursesController coursesController;
  final LogoutCallback onLogout;

  const CoursesView({
    Key? key,
    required this.coursesController,
    required this.onLogout,
  }) : super(key: key);

  @override
  CoursesViewState createState() => CoursesViewState();
}

class CoursesViewState extends State<CoursesView> {
  bool _loading = true;
  List<Course> _courses = [];

  @override
  void initState() {
    super.initState();
    _fetchCourses();
  }

  void _onCourseTapped(Course course) async {
    await StorageService.saveCurrentCourse(course);
    final token = await StorageService.getToken();
    if (token == null) {
      await StorageService.deleteToken();
      Navigator.pushReplacementNamed(context, AppRoutes.login);
      return;
    }
    scheduleMicrotask(() {
      Navigator.pushNamed(
        context,
        AppRoutes.categories,
        arguments: {
          'courseId': course.courseId,
          'courseName': course.courseName,
          'token': token,
        },
      );
    });
  }

  Future<void> _fetchCourses() async {
    setState(() {
      _loading = true;
    });

    try {
      _courses = await widget.coursesController.fetchCourses();
      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Courses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: widget.onLogout,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : CoursesForm(
              courses: _courses,
              onCourseTapped: _onCourseTapped,
            ),
    );
  }
}
