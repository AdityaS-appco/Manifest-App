import 'dart:convert';
import 'package:flutter/services.dart';
import '../../helper/import.dart';

class Languages extends Translations {
  // @override
  Map<String, Map<String, String>> translations = {};

  Future<void> loadTranslations() async {
    String englishJson = await rootBundle.loadString('assets/language/en-US.json');
    translations['en_US'] = Map<String, String>.from(json.decode(englishJson));
    String spanishJson = await rootBundle.loadString('assets/language/es-ES.json');
    translations['es_ES'] = Map<String, String>.from(json.decode(spanishJson));
    String japaneseJson = await rootBundle.loadString('assets/language/ja-JP.json');
    translations['ja_JP'] = Map<String, String>.from(json.decode(japaneseJson));
  }

  @override
  Map<String, Map<String, String>> get keys => translations;
}