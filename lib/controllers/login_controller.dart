import 'package:thesis/models/user_model.dart';
import 'package:thesis/controllers/user_controller.dart';

class LoginController {
  final UserController _userController;

  LoginController(this._userController);

  Future<void> login(String username, String password) async {
    final user = User(username: username, password: password);
    await _userController.login(user);
  }
}
