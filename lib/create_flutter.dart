import 'package:create_flutter/classes/classes.dart';
import 'package:create_flutter/i18n/i18n.dart';

void run() async {
  final lang = I18n();
  await lang.loadDictionaryFromJson();

  // print(lang.t("selectOne"));

  List<Question> questions = [
    TextQuestion(
      question: 'What is the app name?',
      transformer: (answer) => answer.toUpperCase(),
    ),
    ChoiceQuestion.single(
      question: 'What is your favorite color?',
      options: ['red', 'green', 'blue'],
    ),
    ChoiceQuestion.multiple(
      question: 'What is your favorite animal?',
      options: ['dog', 'cat', 'bird'],
    ),
  ];

  var quiz = Quiz(
    onStart: (console) {
      console.writeLine(r'''
   _____                _         ______ _       _   _             
  / ____|              | |       |  ____| |     | | | |            
 | |     _ __ ___  __ _| |_ ___  | |__  | |_   _| |_| |_ ___ _ __  
 | |    | '__/ _ \/ _` | __/ _ \ |  __| | | | | | __| __/ _ \ '__| 
 | |____| | |  __/ (_| | ||  __/ | |    | | |_| | |_| ||  __/ |    
  \_____|_|  \___|\__,_|\__\___| /\|    |_|\__,_|\__|\__\___|_|    
                                /  \   _ __  _ __                  
                               / /\ \ | '_ \| '_ \                 
                              / ____ \| |_) | |_) |                
                             /_/    \_\ .__/| .__/                 
                                      | |   | |                    
                                      |_|   |_|                    
''');
    },
    questions: questions,
  );
  quiz.start();
}
