import 'dart:io';

abstract class Question {
  final String question;
  final String? prefix;
  final String? suffix;

  Question({
    required this.question,
    this.prefix,
    this.suffix,
  });

  void ask() {
    print('$prefix$question$suffix');
  }

  T getAnswer<T>() {
    while (true) {
      var answer = (stdin.readLineSync() ?? "").trim();
      var error = validateAnswer(answer);

      if (error == null) {
        return answer as T;
      } else {
        print('Invalid: $error');
      }
    }
  }

  String? validateAnswer(String? answer);
}
