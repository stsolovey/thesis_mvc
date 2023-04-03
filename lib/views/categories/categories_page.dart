import 'package:flutter/material.dart';
import 'package:thesis/controllers/categories_controller.dart';
import 'package:thesis/routes.dart';
import 'package:thesis/services/api_service.dart';
import 'package:thesis/services/storage_serivce.dart';
import 'package:thesis/views/categories/categories_view.dart';

class CategoriesPage extends StatefulWidget {
  final String courseId;
  final String courseName;
  final String token;

  const CategoriesPage({
    Key? key,
    required this.courseId,
    required this.courseName,
    required this.token,
  }) : super(key: key);

  @override
  CategoriesPageState createState() => CategoriesPageState();
}

class CategoriesPageState extends State<CategoriesPage> {
  final CategoriesController _categoriesController =
      CategoriesController(ApiService());

  Future<void> _logoutAndNavigate() async {
    await StorageService.deleteToken();
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return CategoriesView(
      categoriesController: _categoriesController,
      courseId: widget.courseId,
      courseName: widget.courseName,
      token: widget.token,
      onLogout: _logoutAndNavigate,
    );
  }
}
