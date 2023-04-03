import 'package:flutter/material.dart';
import 'register_form.dart';

class RegisterView extends StatelessWidget {
  final void Function(String username, String password, String email)
      onRegister;
  final bool isLoading;

  const RegisterView({
    Key? key,
    required this.onRegister,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: RegisterForm(
            onSubmit: onRegister,
            isLoading: isLoading,
          ),
        ),
      ),
    );
  }
}
