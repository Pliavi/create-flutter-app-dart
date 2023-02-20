import 'dart:io';

import 'package:create_flutter/classes/classes.dart';
import 'package:create_flutter/i18n/i18n.dart';
import 'package:dart_console/dart_console.dart';

final header = r'''
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
''';

void run() async {
  final lang = I18n();
  await lang.loadDictionaryFromJson();

  List<Question> questions = [
    TextQuestion(
      question: 'What is the app name?',
      suffix: 'eg. My App',
    ),
    TextQuestion(
      question: 'What is the package/org name?',
      suffix: 'eg. com.example.myapp',
    ),
    ChoiceQuestion.multiple(
      question: "Which platforms will support?",
      choices: [
        "iOS",
        "Android",
        "Windows",
        "Linux",
        "MacOS",
        "Web",
      ],
    ),
  ];

  var quiz = Quiz(
    onStart: (console) {
      console.writeLine(header);
    },
    onFinish: (answers, console) async {
      final appName = answers[0].first;
      final packageName = answers[1].first;
      final platforms = answers[2]
          .map(
            (platform) => platform.toLowerCase(),
          )
          .join(',');

      console.writeLine('Creating $packageName$appName...');
      console.writeLine('Platforms: $platforms');

      final workingDirectory = Platform.environment["PWD"];
      var result = await Process.run(
        'flutter',
        [
          'create',
          '--org',
          packageName,
          '--platforms',
          platforms,
          '--project-name',
          appName,
          appName,
        ],
        runInShell: true,
        workingDirectory: workingDirectory,
      );

      stdout.write(result.stdout);
      stderr.write(result.stderr);
    },
    questions: questions,
  );

  quiz.start();
}
