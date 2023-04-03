import 'package:flutter/cupertino.dart';
import 'package:thesis/models/exercise_model.dart';
import 'package:thesis/services/api_service.dart';

class ExerciseController with ChangeNotifier {
  final ApiService _apiService = ApiService();
  Exercise? _exercise;
  String? _answer;
  bool _isLoading = false;
  bool _waitingForResponse = false;

  Exercise? get exercise => _exercise;
  String? get answer => _answer;
  bool get isLoading => _isLoading;
  bool get waitingForResponse => _waitingForResponse;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setWaitingForResponse(bool value) {
    _waitingForResponse = value;
    notifyListeners();
  }

  void setExercise(Exercise? value) {
    _exercise = value;
    notifyListeners();
  }

  void setAnswer(String? value) {
    _answer = value;
    notifyListeners();
  }

  Future<void> getExercise(String token, String categoryId) async {
    setLoading(true);
    try {
      final response = await _apiService.getExercise(token, categoryId);
      setExercise(Exercise.fromJson(response));
      setLoading(false);
    } catch (e) {
      setLoading(false);
      throw Exception('Failed to fetch exercise: $e');
    }
  }

  Future<void> sendAnswer(
      String token, String exerciseId, String userInput) async {
    setWaitingForResponse(true);
    try {
      final response =
          await _apiService.sendAnswer(token, exerciseId, userInput);
      setAnswer(response['expected']);
      setWaitingForResponse(false);
    } catch (e) {
      setWaitingForResponse(false);
      throw Exception('Failed to send answer: $e');
    }
  }
}
