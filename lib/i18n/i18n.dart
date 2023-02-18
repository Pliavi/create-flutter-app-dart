import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

class I18n {
  final String _language;
  Map<String, String>? dictionary;

  I18n() : _language = Platform.localeName;

  String get language => _language;

  String t(String key) {
    return dictionary?[key] ?? key;
  }

  Future<void> loadDictionaryFromJson() async {
    final language = _language.split('_').first.toLowerCase();
    final path = p.join(
      Directory.current.path,
      'lib',
      'i18n',
      'dictionaries',
      '$language.json',
    );

    final file = File(path);

    try {
      final contents = await file.readAsString();

      dictionary = Map.from(
        jsonDecode(contents),
      );
    } catch (e) {
      print(e);
    }
  }
}
