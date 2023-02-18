import 'package:create_flutter/constants/constants.dart';

class StringFragmentStyle {
  final ANSIColor? foregroundColor;
  final ANSIBackgroundColor? backgroundColor;

  const StringFragmentStyle({
    this.foregroundColor,
    this.backgroundColor,
  });
}

class QuestionConfig {
  final StringFragmentStyle prefixStyle;
  final StringFragmentStyle suffixStyle;
  final String prefixIcon;
  final String suffixIcon;

  QuestionConfig({
    this.prefixStyle = const StringFragmentStyle(),
    this.suffixStyle = const StringFragmentStyle(),
    this.prefixIcon = '',
    this.suffixIcon = '',
  });
}
