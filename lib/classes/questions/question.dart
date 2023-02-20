import 'package:create_flutter/classes/console_singleton.dart';
import 'package:dart_console/dart_console.dart';

typedef FormatterFunction = String Function(String answer);

abstract class Question {
  final String question;
  final String prefix;
  final String suffix;
  List<String> rawAnswer = [];
  int linesWritten = 0;

  Console get console => ConsoleSingleton.instance;

  Question({
    required this.question,
    this.prefix = "?",
    this.suffix = '',
  });

  void renderQuestionTemplate();
  void renderOnAnswerTemplate(List<String> rawAnswer);
  void renderErrorTemplate(String error);
  void onValidAnswer(List<String> rawAnswer);
  void onAnswerError(String error);
  void listenForAnswer();

  List<String> convertAnswerToList(String? answer) {
    if (answer == null) return [];

    return answer
        .split(',')
        .map((answer) => answer.trim())
        .where((answer) => answer != '')
        .toList();
  }

  List<String> getRawAnswer() {
    return rawAnswer;
  }

  String getFormattedAnswer() {
    return formatAnswer(rawAnswer);
  }

  void clearQuestion() {
    for (var i = 0; i < linesWritten; i++) {
      final row = console.cursorPosition?.row ?? 1;
      console.eraseCursorToEnd();
      console.cursorPosition = Coordinate(row - 1, 0);
    }
    linesWritten = 0;
  }

  void write(String text) {
    console.write(text);
  }

  void writeError(String text) {
    console.setForegroundColor(ConsoleColor.red);
    console.write(text);
    console.resetColorAttributes();
  }

  void writeHint(String text) {
    console.setForegroundColor(ConsoleColor.blue);
    console.write(text);
    console.resetColorAttributes();
  }

  String? read() {
    var text = console.readLine();
    console.cursorUp();
    pushLine();

    return text;
  }

  void pushLine() {
    console.write("\n");
    linesWritten++;
  }

  void pushLines(int lines) {
    for (var i = 0; i < lines; i++) {
      pushLine();
    }
  }

  void moveOrSetCursor({
    int byRows = 0,
    int byCols = 0,
    int? setCol,
    int? setRow,
  }) {
    assert(
      (setCol != null && byCols != 0) || (setCol == null && byCols == 0),
      "Cannot set both setCol and byCols at the same time",
    );
    assert(
      (setRow != null && byRows != 0) || (setRow == null && byRows == 0),
      "Cannot set both setRow and byRows at the same time",
    );
    assert(byRows > 0, "You can't move down");

    final currentRow = console.cursorPosition?.row ?? 1;
    final currentCol = console.cursorPosition?.col ?? 1;

    if (setRow != null && setRow < 1) {
      final hasMovedTooFarUp = (byRows * -1) > linesWritten;
      final hasSetTooFarUp = setRow < currentRow - linesWritten;

      if (hasMovedTooFarUp) {
        throw Exception(
          "Cannot move cursor up by $byRows(lines written: $linesWritten)",
        );
      }
      if (hasSetTooFarUp) {
        throw Exception(
          "Cannot set cursor to row $setRow(this question starts at row ${currentRow - linesWritten})",
        );
      }
    }

    var coordinate = Coordinate(
      setRow ?? currentRow + byRows,
      setCol ?? currentCol + byCols,
    );

    console.cursorPosition = coordinate;

    if (byRows != 0) {
      linesWritten += byRows;
    }
    if (setRow != null) {
      linesWritten = linesWritten - (currentRow - setRow);
    }
  }

  String formatAnswer(List<String> rawAnswer);
  String? validateAnswer(List<String>? rawAnswer);
}
