import 'package:hive_flutter/hive_flutter.dart';
import 'models/course_model.dart';

// Hive TypeIds:
// 0 - Course
// 1 - Category
// 2 - Lesson

import 'package:flutter/material.dart';
import 'views/categories/categories_page.dart';

import 'services/storage_serivce.dart';
import 'views/exercise/exercise_page.dart';
import 'views/splash_screen.dart';
import 'views/login/login_page.dart';

import 'views/register/register_page.dart';
import 'views/courses/courses_page.dart';
import 'routes.dart';
import 'controllers/exercise_controller.dart';
import 'package:provider/provider.dart';

void main() async {
  await StorageService.initHive();
  await Hive.initFlutter();
  Hive.registerAdapter(CourseAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thesis Final',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.login: (context) => const LoginPage(),
        AppRoutes.register: (context) => const RegisterPage(),
        AppRoutes.courses: (context) => const CoursesPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.categories:
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => CategoriesPage(
                courseId: args['courseId'],
                courseName: args['courseName'],
                token: args['token'],
              ),
            );
          case AppRoutes.exercise:
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => ExerciseController(),
                child: ExercisePage(
                  token: args['token'],
                  categoryId: args['categoryId'],
                ),
              ),
            );
          default:
            return MaterialPageRoute(
                builder: (context) => const SizedBox.shrink());
        }
      },
    );
  }
}
