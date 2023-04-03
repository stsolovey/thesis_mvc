import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesis/controllers/exercise_controller.dart';
import 'package:thesis/views/exercise/exercise_view.dart';

class ExercisePage extends StatelessWidget {
  final String token;
  final String categoryId;

  const ExercisePage({
    required this.token,
    required this.categoryId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExerciseController(),
      child: Consumer<ExerciseController>(
        builder: (context, controller, _) {
          return ExerciseView(token: token, categoryId: categoryId);
        },
      ),
    );
  }
}
