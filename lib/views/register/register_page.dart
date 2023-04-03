import 'package:flutter/material.dart';
import 'package:thesis/controllers/register_controller.dart';
import 'package:thesis/services/api_service.dart';
import 'package:thesis/services/storage_serivce.dart';
import 'package:thesis/views/register/register_view.dart';
import 'package:thesis/routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  final RegisterController _registerController =
      RegisterController(ApiService());

  void _navigateToCourses() {
    Navigator.pushReplacementNamed(context, AppRoutes.courses);
  }

  void _onRegister(String username, String password, String email) async {
    _isLoading.value = true;

    try {
      final registeredUser =
          await _registerController.registerUser(username, password, email);
      await StorageService.saveToken(registeredUser.token!);
      _navigateToCourses();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoading,
      builder: (context, isLoading, child) {
        return RegisterView(
          onRegister: _onRegister,
          isLoading: isLoading,
        );
      },
    );
  }
}
