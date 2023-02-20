import 'package:create_flutter/classes/classes.dart';
import 'package:create_flutter/classes/console_singleton.dart';
import 'package:dart_console/dart_console.dart';

class TextQuestion extends Question {
  TextQuestion({
    required super.question,
    super.prefix,
    super.suffix,
  });

  @override
  formatAnswer(rawAnswer) {
    return rawAnswer.join("");
  }

  @override
  List<String> convertAnswerToList(String? answer) {
    if (answer == null) return [];

    return [answer.trim()];
  }

  @override
  listenForAnswer() {
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
  onValidAnswer(rawAnswer) {
    this.rawAnswer = rawAnswer;
    renderOnAnswerTemplate(rawAnswer);
  }

  @override
  onAnswerError(error) => renderErrorTemplate(error);

  @override
  renderErrorTemplate(error) {
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
  renderOnAnswerTemplate(answer) {
    clearQuestion();
    renderQuestionTemplate();
    moveOrSetCursor(
      byRows: -1,
      setCol: prefix.length + question.length + 2,
    );
    console.eraseCursorToEnd();
    writeHint(answer.first);
    pushLine();
  }

  @override
  renderQuestionTemplate() {
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
  validateAnswer(rawAnswer) {
    return (rawAnswer == null || rawAnswer.isEmpty || rawAnswer.first.isEmpty)
        ? "Answer cannot be empty"
        : null;
  }
}
