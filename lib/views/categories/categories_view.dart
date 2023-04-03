import 'package:flutter/material.dart';
import 'package:thesis/controllers/categories_controller.dart';
import 'package:thesis/models/category_model.dart';
import 'package:thesis/views/categories/categories_form.dart';
import 'package:thesis/views/exercise/exercise_page.dart';

typedef LogoutCallback = void Function();

class CategoriesView extends StatefulWidget {
  final CategoriesController categoriesController;
  final String courseId;
  final String courseName;
  final String token;
  final LogoutCallback onLogout;

  const CategoriesView({
    Key? key,
    required this.categoriesController,
    required this.courseId,
    required this.courseName,
    required this.token,
    required this.onLogout,
  }) : super(key: key);

  @override
  CategoriesViewState createState() => CategoriesViewState();
}

class CategoriesViewState extends State<CategoriesView> {
  bool _loading = true;
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      _categories = await widget.categoriesController
          .fetchCategories(widget.token, widget.courseId);
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

  void _onCategoryTapped(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExercisePage(
          token: widget.token,
          categoryId: category.id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: widget.onLogout,
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : CategoriesForm(
              categories: _categories,
              onCategoryTapped: _onCategoryTapped,
            ),
    );
  }
}
