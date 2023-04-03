import 'package:flutter/material.dart';
import 'package:thesis/controllers/courses_controller.dart';
import 'package:thesis/routes.dart';
import 'package:thesis/services/api_service.dart';
import 'package:thesis/services/storage_serivce.dart';
import 'package:thesis/views/courses/courses_view.dart';
import 'dart:async';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  CoursesPageState createState() => CoursesPageState();
}

class CoursesPageState extends State<CoursesPage> {
  final CoursesController _coursesController = CoursesController(ApiService());

  Future<void> _logoutAndNavigate() async {
    await StorageService.deleteToken();
    scheduleMicrotask(() {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CoursesView(
      coursesController: _coursesController,
      onLogout: _logoutAndNavigate,
    );
  }
}
