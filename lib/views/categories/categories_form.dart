import 'package:flutter/material.dart';
import 'package:thesis/models/category_model.dart';

typedef CategoryTappedCallback = void Function(Category category);

class CategoriesForm extends StatelessWidget {
  final List<Category> categories;
  final CategoryTappedCallback onCategoryTapped;

  const CategoriesForm({
    Key? key,
    required this.categories,
    required this.onCategoryTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return ListTile(
          title: Text(category.name),
          onTap: () => onCategoryTapped(category),
        );
      },
    );
  }
}
