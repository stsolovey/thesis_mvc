import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesis/controllers/exercise_controller.dart';

class ExerciseView extends StatefulWidget {
  final String token;
  final String categoryId;

  const ExerciseView({
    required this.token,
    required this.categoryId,
    Key? key,
  }) : super(key: key);

  @override
  ExerciseViewState createState() => ExerciseViewState();
}

class ExerciseViewState extends State<ExerciseView> {
  final TextEditingController _userInputController = TextEditingController();
  bool _answerSent = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getExercise();
    });
  }

  Future<void> _getExercise() async {
    final controller = Provider.of<ExerciseController>(context, listen: false);
    await controller.getExercise(widget.token, widget.categoryId);
  }

  Future<void> _sendAnswer() async {
    final controller = Provider.of<ExerciseController>(context, listen: false);
    final userInput = _userInputController.text;
    await controller.sendAnswer(
        widget.token, controller.exercise!.id, userInput);
    setState(() {
      _answerSent = true;
    });
  }

  IconData getAnswerIcon(bool result) {
    return result ? Icons.check : Icons.close;
  }

  Color getAnswerColor(bool result) {
    return result ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ExerciseController>(context);
    final bool userInputEmpty = _userInputController.text.isEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise'),
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Exercise title
                  Text(
                    'Переведите предложение',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16.0),

                  // Exercise prompt
                  SelectableText(
                    controller.exercise?.sentence ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16.0),

                  // User input text field
                  TextField(
                    controller: _userInputController,
                    onChanged: (_) {
                      if (!_answerSent) {
                        setState(() {});
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Type your answer here',
                    ),
                    minLines: 1,
                    maxLines: 5,
                    enabled: !_answerSent,
                  ),
                  const SizedBox(height: 16.0),

                  if (_answerSent)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        controller.waitingForResponse
                            ? const CircularProgressIndicator()
                            : Icon(
                                getAnswerIcon(controller.answer ==
                                    _userInputController.text),
                                color: getAnswerColor(controller.answer ==
                                    _userInputController.text),
                              ),
                        Text(controller.answer ?? ''),
                        ElevatedButton(
                          onPressed: controller.isLoading ? null : _getExercise,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                controller.answer == _userInputController.text
                                    ? Colors.green
                                    : controller.answer != null
                                        ? Colors.red
                                        : Theme.of(context).primaryColor,
                          ),
                          child: const Text('Continue'),
                        ),
                      ],
                    )
                  else
                    controller.waitingForResponse
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: userInputEmpty ? null : _sendAnswer,
                            child: const Text('Send answer'),
                          ),
                ],
              ),
            ),
    );
  }
}
