import 'package:create_flutter/questions/questions.dart';

class MultipleChoiceQuestion extends Question {
  final List<String> options;
  final bool allowMultiple;

  MultipleChoiceQuestion({
    required super.question,
    super.prefix,
    super.suffix,
    required this.options,
    this.allowMultiple = false,
  });

  @override
  void ask() {
    super.ask();

    var optionNumber = 1;
    for (var option in options) {
      print('  $optionNumber. $option');
      optionNumber++;
    }
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
  StringList getAnswer<StringList>() {
    var answers = super.getAnswer<String>();

    return answers
        .split(',')
        .map((answer) => options.elementAt(int.tryParse(answer)! - 1))
        .toSet()
        .toList() as StringList;
  }
}
