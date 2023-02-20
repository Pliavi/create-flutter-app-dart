import 'package:create_flutter/classes/classes.dart';
import 'package:create_flutter/classes/console_singleton.dart';
import 'package:dart_console/dart_console.dart';

class Quiz {
  Console get console => ConsoleSingleton.instance;

  final void Function(Console console)? onStart;
  final void Function(List<List<String>> answers, Console console)? onFinish;

  final List<Question> questions;
  List<List<String>> answers = [];

  Quiz({
    this.onStart,
    this.onFinish,
    required this.questions,
  });

  start() {
    console.showCursor();
    onStart?.call(console);

    for (var question in questions) {
      question.renderQuestionTemplate();
      question.listenForAnswer();
      answers.add(question.getRawAnswer());
    }

    onFinish?.call(answers, console);
  }
}
