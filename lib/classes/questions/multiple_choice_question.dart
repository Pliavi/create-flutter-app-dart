import 'package:create_flutter/classes/classes.dart';
import 'package:create_flutter/classes/console_singleton.dart';
import 'package:dart_console/dart_console.dart';

class ChoiceQuestion extends Question {
  final List<String> options;
  final bool allowMultiple;

  ChoiceQuestion.multiple({
    required super.question,
    super.prefix,
    super.suffix = 'select multiples using comma (eg. 1,2)',
    required this.options,
  }) : allowMultiple = true;

  ChoiceQuestion.single({
    required super.question,
    super.prefix,
    super.suffix = 'select one only',
    required this.options,
  }) : allowMultiple = false;

  @override
  int showQuestion() {
    final questionLength = super.showQuestion();

    var optionNumber = 1;
    for (var option in options) {
      console.writeLine('  $optionNumber. $option');
      optionNumber++;
    }

    return questionLength;
  }

  @override
  String? validateAnswer(String? answer) {
    if (answer == null || answer.isEmpty) {
      return 'Answer cannot be empty';
    }

    Set answerNumbers =
        answer.split(',').map((option) => int.tryParse(option)).toSet();

    if (answerNumbers.isEmpty || answerNumbers.contains(null)) {
      return '$answer (must be a number)';
    }

    if (answerNumbers.length > 1 && !allowMultiple) {
      return 'Only one answer is allowed';
    }

    if (!answerNumbers
        .every((answer) => answer >= 1 && answer <= options.length)) {
      return '$answer (must be between 1 and ${options.length})';
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

      if (error == null) {
        return answer
            .split(',')
            .map((answer) {
              final option = options.elementAt(int.tryParse(answer)! - 1);

              return format?.call(option) ?? option;
            })
            .toSet()
            .toList();
      }

      console.writeErrorLine('Invalid: $error');
    }
  }

  @override
  void showAnswer(answer) {
    final optionsRows = options.length;
    final cursorRow = console.cursorPosition!.row - 3 - optionsRows;

    console.cursorPosition = Coordinate(cursorRow, 0);

    final questionLength = showQuestion();

    console.cursorPosition = Coordinate(cursorRow, questionLength);

    console.eraseCursorToEnd();
    console.write(" ${answer.join(',')}");
    console.writeLine();
  }
}
