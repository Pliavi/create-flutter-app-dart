import 'package:create_flutter/classes/console_singleton.dart';
import 'package:dart_console/dart_console.dart';

typedef FormatterFunction = String Function(String answer);

abstract class Question {
  final String question;
  final String prefix;
  final String suffix;

  Console get console => ConsoleSingleton.instance;

  Question({
    required this.question,
    this.prefix = "?",
    this.suffix = '',
  });

  int showQuestion() {
    final localPrefix = prefix.isEmpty ? "" : "$prefix ";
    final localSuffix = suffix.isEmpty ? "" : " $suffix";

    console.setForegroundColor(ConsoleColor.brightBlack);
    console.write(localPrefix);
    console.resetColorAttributes();

    console.write(question);

    console.setForegroundColor(ConsoleColor.brightBlack);
    console.write(localSuffix);
    console.resetColorAttributes();
    console.writeLine();

    return "$localPrefix$question$localSuffix".length;
  }

  List<String> getAnswer({
    FormatterFunction? format,
  });

  void showAnswer(List<String> answer);

  String? validateAnswer(String answer);
}
