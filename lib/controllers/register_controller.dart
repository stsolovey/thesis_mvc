import 'package:thesis/models/user_model.dart';
import 'package:thesis/services/api_service.dart';

class RegisterController {
  final ApiService apiService;

  RegisterController(this.apiService);

  Future<User> registerUser(
      String username, String password, String email) async {
    try {
      final accessToken = await apiService.register(username, password, email);
      final registeredUser = User(
        username: username,
        password: password,
        email: email,
        token: accessToken,
      );
      return registeredUser;
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }
}
