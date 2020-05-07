import 'package:flutter_strings_localization/translate_manager.dart';

class LocalizationsFiles {
  static final LocalizationsFiles _instance = LocalizationsFiles._();

  factory LocalizationsFiles() {
    return _instance;
  }

  LocalizationsFiles._();

  Map<String, Map<String, Map<PluralsKey, String>>> _localeList = {};

  set save(Map<String, Map<String, Map<PluralsKey, String>>> value) {
    _localeList.addAll(value);
  }

  get files {
    return _localeList;
  }
}
