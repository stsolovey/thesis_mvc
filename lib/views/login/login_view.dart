
import 'package:flutter/material.dart';
import 'login_form.dart';

class LoginView extends StatelessWidget {
  final void Function(BuildContext context, String username, String password)
      onSubmit;
  final ValueNotifier<bool> isLoading;

  const LoginView({required this.onSubmit, required this.isLoading, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginForm(
      onSubmit: onSubmit,
      isLoading: isLoading,
    );
  }
}
