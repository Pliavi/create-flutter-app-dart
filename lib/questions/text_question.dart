import 'package:create_flutter/questions/questions.dart';

typedef FormatterFunction = String Function(String answer);
typedef StringList = List<String>;

class TextQuestion extends Question {
  final FormatterFunction? transformer;

  TextQuestion({
    required super.question,
    super.prefix,
    super.suffix,
    this.transformer,
  });

  @override
  String? validateAnswer(String? answer) {
    if (answer == null || answer.isEmpty) {
      return 'Answer cannot be empty';
    }

    return null;
  }

  @override
  String getAnswer<String>([FormatterFunction? formatterFunction]) {
    var answer = super.getAnswer();
    String formattedAnswer =
        formatterFunction != null ? formatterFunction(answer) : answer;

    return formattedAnswer;
  }
}
