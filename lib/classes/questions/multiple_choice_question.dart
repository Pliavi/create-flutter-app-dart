import 'package:create_flutter/classes/classes.dart';
import 'package:create_flutter/classes/console_singleton.dart';
import 'package:dart_console/dart_console.dart';

class ChoiceQuestion extends Question {
  final List<String> choices;

  final bool allowMultiple;

  ChoiceQuestion.multiple({
    required super.question,
    super.prefix,
    super.suffix = 'select multiples using comma (eg. 1,2)',
    required this.choices,
  }) : allowMultiple = true;

  ChoiceQuestion.single({
    required super.question,
    super.prefix,
    super.suffix = 'select one only',
    required this.choices,
  }) : allowMultiple = false;

  @override
  String formatAnswer(List<String> rawAnswer) {
    return rawAnswer.join(", ");
  }

  @override
  void listenForAnswer() {
    final rawAnswer = convertAnswerToList(read());
    final error = validateAnswer(rawAnswer);

    if (error != null) {
      onAnswerError(error);
      listenForAnswer();
    } else {
      onValidAnswer(rawAnswer);
    }
  }

  @override
  onAnswerError(error) => renderErrorTemplate(error);

  @override
  void onValidAnswer(List<String> rawAnswer) {
    this.rawAnswer = rawAnswer;
    renderOnAnswerTemplate(rawAnswer);
  }

  @override
  void renderErrorTemplate(String error) {
    clearQuestion();
    renderQuestionTemplate();
    pushLine();
    writeError(error);
    moveOrSetCursor(
      byRows: -1,
      setCol: 0,
    );
  }

  @override
  void renderOnAnswerTemplate(List<String> rawAnswer) {
    clearQuestion();
    renderQuestionLine();
    moveOrSetCursor(
      byRows: -1,
      setCol: prefix.length + question.length + 2,
    );
    console.eraseCursorToEnd();
    writeHint(rawAnswer.join(", "));

    pushLine();
  }

  @override
  void renderQuestionTemplate() {
    renderQuestionLine();
    for (var i = 0; i < choices.length; i++) {
      write('  ');
      console.setForegroundColor(ConsoleColor.brightBlack);
      write((i + 1).toString());
      write(') ');
      console.resetColorAttributes();
      write(choices[i]);
      pushLine();
    }
  }

  void renderQuestionLine() {
    console.setForegroundColor(ConsoleColor.brightBlack);
    write(prefix);
    console.resetColorAttributes();
    write(' ');
    write(question);
    write(' ');
    console.setForegroundColor(ConsoleColor.brightBlack);
    write(suffix);
    console.resetColorAttributes();
    pushLine();
  }

  @override
  List<String> convertAnswerToList(String? answer) {
    final answers = super.convertAnswerToList(answer);

    return answers
        .map((answer) {
          final number = int.tryParse(answer);
          final isPositiveNumber = (number != null && number > 0);
          final isChoiceIndex = (isPositiveNumber && number <= choices.length);

          return (isChoiceIndex) ? choices[number - 1] : null;
        })
        .where((answer) => answer != null)
        .toList()
        .cast();
  }

  @override
  validateAnswer(rawAnswer) {
    return (rawAnswer == null || rawAnswer.isEmpty)
        ? "Answer cannot be empty"
        : null;
  }
}
