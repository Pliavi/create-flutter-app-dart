# Create Flutter App

This is a CLI tool to enforce a good startup for a Flutter project.

This is based on [a video I watched in Youtube][youtubevideo] talking about how this simple things like setting the app name, org name, platforms and other things can be important for someone who is showing the app in an interview.

But I think this can be useful for anyone who wants to start a new project and wants to enforce some good practices, so I decided to create this tool.

And it will also be used to me to create a package to create this kind of CLI tools, in some way similar to [Inquirer.js][inquirergithub].

## Usage

Just run the command `create-flutter-app` and follow the instructions:

```bash
create-flutter-app
```

## Known issues

- [ ] If you put an "\n" in the question, it will break the CLI rendering
  - Critical level: low
  - Fix implementation: Run through the question string and increment the line count for each "\n" found

## TODOS:

- [ ] Overwrite or update an already created project
  - Priority: 5(low)
  - It currently update by the default behavior of `flutter create`, but i'll let the user choose if he wants to overwrite or update
- [ ] Improve structure
  - Priority: 1(max)
- [ ] Add default value option
  - Priority: 4(medium)
- [ ] Add validation option
  - Priority: 2(high)
- [ ] Add more question types
  - Priority: 2(high)
- [ ] Add tests
  - Priority: 2(high)
- [ ] Add multi-language support
  - Priority: 4(medium)
- [ ] Create a iconical design like [@clack/prompts][clackgithub]
  - Priority: 5(low)

### Question types

- [x] Text question
- [x] Numbered choice question
  - [x] Single choice
  - [x] Multiple choice
- [ ] Password question
- [ ] Confirm (y/n) question
- [ ] Multiline question
- [ ] Checkbox choice question
- [ ] Radio choice question

### Structure ideas

I'm not sure, but this current structure does not feel good enough, it's too hard to handle the questions and the raw and formatted answers.

- The current up there with a list of questions inside a controller class

```dart
void run() async {
  final lang = I18n();
  await lang.loadDictionaryFromJson();

  var quiz = Quiz(
    questions: [
    TextQuestion(question: 'What is the app name?'),
    ChoiceQuestion.multiple(
      question: "Which platforms do you want to support?",
      choices: ["Android", "iOS", "Web"],
    );
  ],
    onStart: (console) {
      console.writeLine("Welcome to the Flutter App Creator");
    },
    onFinish: (console, answers) {
      console.writeLine("Thanks for using the Flutter App Creator");
    },
  );

  quiz.start();
}
```

- As a builder

```dart
final quiz = Quiz.addTextQuestion(
  name: "app_name",
  question: "What is the App name?",
).addChoiceQuestion(
  name: "platforms",
  question: "Which platforms do you want to support?",
  choices: ["Android", "iOS", "Web"],
).onComplete((answers) {
  print(answers);
}).start();

final questions = quiz.questions;
final answers = quiz.answers;
```

- A more "functional" way, without any controller, each question is a function that returns a future

```dart
final appName = await Question.text("What is the App name?");
final platforms = await Question.choice(
  type: ChoiceType.checkbox,
  question: "Which platforms do you want to support?",
  choices: ["Android", "iOS", "Web"],
);
```

[inquirergithub]: https://github.com/SBoudrias/Inquirer.js
[clackgithub]: https://github.com/natemoo-re/clack/tree/main/packages/prompts
[youtubevideo]: https://www.youtube.com/watch?v=_wGqTXhAgMM
