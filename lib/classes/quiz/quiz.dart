import 'package:create_flutter/classes/classes.dart';
import 'package:create_flutter/classes/console_singleton.dart';
import 'package:dart_console/dart_console.dart';

class Quiz {
  Console get console => ConsoleSingleton.instance;

  final void Function(Console console)? onStart;
  final List<Question> questions;

  Quiz({
    this.onStart,
    required this.questions,
  });

  start() {
    console.hideCursor();
    onStart?.call(console);

    var answers = [];
    for (var question in questions) {
      question.showQuestion();
      final answer = question.getAnswer();
      answers.add(answer);
      question.showAnswer(answer);
    }

    ConsoleSingleton.instance.writeLine(answers);
  }
}
