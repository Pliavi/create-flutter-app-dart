class ANSIColor {
  final int value;
  const ANSIColor(this.value);

  @override
  String toString() {
    if (value == 0) {
      return '\x1B[0m';
    }

    return '\x1B[38;5;${value}m';
  }
}

class ANSIBackgroundColor {
  final int value;
  const ANSIBackgroundColor(this.value);

  @override
  String toString() {
    if (value == 0) {
      return '\x1B[0m';
    }

    return '\x1B[48;5;${value}m';
  }
}

abstract class ANSIColors {
  static const reset = ANSIColor(0);
  static const black = ANSIColor(0);
  static const red = ANSIColor(1);
  static const green = ANSIColor(2);
  static const yellow = ANSIColor(3);
  static const blue = ANSIColor(4);
  static const magenta = ANSIColor(5);
  static const cyan = ANSIColor(6);
  static const white = ANSIColor(7);
  static const gray = ANSIColor(8);
  static const brightRed = ANSIColor(9);
  static const brightGreen = ANSIColor(10);
  static const brightYellow = ANSIColor(11);
  static const brightBlue = ANSIColor(12);
  static const brightMagenta = ANSIColor(13);
  static const brightCyan = ANSIColor(14);
  static const brightWhite = ANSIColor(15);
}

abstract class ANSIBackgroundColors {
  static const reset = ANSIBackgroundColor(0);
  static const black = ANSIBackgroundColor(0);
  static const red = ANSIBackgroundColor(1);
  static const green = ANSIBackgroundColor(2);
  static const yellow = ANSIBackgroundColor(3);
  static const blue = ANSIBackgroundColor(4);
  static const magenta = ANSIBackgroundColor(5);
  static const cyan = ANSIBackgroundColor(6);
  static const white = ANSIBackgroundColor(7);
  static const gray = ANSIBackgroundColor(8);
  static const brightRed = ANSIBackgroundColor(9);
  static const brightGreen = ANSIBackgroundColor(10);
  static const brightYellow = ANSIBackgroundColor(11);
  static const brightBlue = ANSIBackgroundColor(12);
  static const brightMagenta = ANSIBackgroundColor(13);
  static const brightCyan = ANSIBackgroundColor(14);
  static const brightWhite = ANSIBackgroundColor(15);
}
