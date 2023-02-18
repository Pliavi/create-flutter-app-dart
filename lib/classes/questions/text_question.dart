import 'package:create_flutter/classes/classes.dart';
import 'package:create_flutter/classes/console_singleton.dart';

class TextQuestion extends Question {
  final FormatterFunction? transformer;

  TextQuestion({
    required super.question,
    super.prefix,
    super.suffix,
    this.transformer,
  });

  @override
  String? validateAnswer(String answer) {
    if (answer.isEmpty) {
      return 'Answer cannot be empty';
    }

    return null;
  }

  @override
  List<String> getAnswer({
    format,
  }) {
    while (true) {
      final answer = (console.readLine() ?? "").trim();
      final error = validateAnswer(answer);
      final formattedAnswer = format?.call(answer) ?? answer;

      if (error == null) {
        return [formattedAnswer];
      }

      console.writeErrorLine('Invalid: $error');
    }
  }

  @override
  void showAnswer(answer) {
    final cursorRow = console.cursorPosition!.row - 2;

    console.cursorPosition = Coordinate(cursorRow, 0);

    final questionLength = showQuestion();

    console.cursorPosition = Coordinate(cursorRow, questionLength);

    console.eraseCursorToEnd();
    console.write(" " + answer.join(','));
    console.writeLine();
  }
}
