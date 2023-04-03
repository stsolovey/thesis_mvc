import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thesis/controllers/user_controller.dart';
import 'package:thesis/routes.dart';
import 'package:thesis/services/api_service.dart';

import 'package:thesis/controllers/login_controller.dart';
import 'login_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final LoginController _loginController;
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  LoginPageState()
      : _loginController = LoginController(UserController(ApiService()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LoginView(
          onSubmit:
              (BuildContext context, String username, String password) async {
            await _login(context, username, password);
          },
          isLoading: _isLoading,
        ),
      ),
    );
  }

  Future<void> _login(
      BuildContext context, String username, String password) async {
    _isLoading.value = true;
    try {
      await _loginController.login(username, password);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, AppRoutes.courses);
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      _isLoading.value = false;
    }
  }
}
