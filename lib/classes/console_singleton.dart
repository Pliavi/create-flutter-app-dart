import 'package:dart_console/dart_console.dart' as dart_console;
export 'package:dart_console/dart_console.dart' show Coordinate;

class ConsoleSingleton {
  final dart_console.Console _console = dart_console.Console();

  static final ConsoleSingleton _singleton = ConsoleSingleton._internal();

  static final dart_console.Console instance = _singleton._console;

  factory ConsoleSingleton() {
    return _singleton;
  }

  ConsoleSingleton._internal();
}
