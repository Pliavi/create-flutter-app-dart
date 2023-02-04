import 'package:create_flutter/questions/questions.dart';

class Quiz {
  List<Question> questions;

  Quiz(this.questions);

  start() {
    var answers = [];
    for (var question in questions) {
      question.ask();
      answers.add(question.getAnswer());
    }

    print(answers);
  }
}

void run() {
  List<Question> questions = [
    TextQuestion(
      question: 'What is your name?',
      prefix: 'Name: ',
      suffix: '!',
      transformer: (answer) => answer.toUpperCase(),
    ),
    MultipleChoiceQuestion(
      question: 'What is your favorite color?',
      prefix: 'Color: ',
      suffix: '!',
      options: ['red', 'green', 'blue'],
    ),
    MultipleChoiceQuestion(
      question: 'What is your favorite animal?',
      prefix: 'Animal: ',
      suffix: '!',
      options: ['dog', 'cat', 'bird'],
      allowMultiple: true,
    ),
  ];

  var quiz = Quiz(questions);
  quiz.start();
}
