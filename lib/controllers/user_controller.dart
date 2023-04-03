import 'package:thesis/models/user_model.dart';
import 'package:thesis/services/api_service.dart';
import 'package:thesis/services/storage_serivce.dart';

class UserController {
  final ApiService _apiService;

  UserController(this._apiService);

  Future<User> login(User user) async {
    final token = await _apiService.login(user.username, user.password);
    await StorageService.saveToken(token);
    return User(username: user.username, password: user.password, token: token);
  }

  Future<User> register(User user) async {
    final token =
        await _apiService.register(user.username, user.password, user.email!);
    await StorageService.saveToken(token);
    return User(
        username: user.username,
        password: user.password,
        email: user.email,
        token: token);
  }
}
