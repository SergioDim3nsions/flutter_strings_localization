import 'package:flutter/material.dart';
import 'package:flutter_strings_localization/localizate_files.dart';

class TranslateManager {
  static final TranslateManager _instance = TranslateManager._();

  LocalizationsFiles _manageLocals;

  bool _isLocaleOverrided = false;
  get isLocaleOverrided => _isLocaleOverrided;
  set isLocaleOverrided(value) => _isLocaleOverrided = value;

  Locale _locale;
  get locale => _locale;
  set locale(value) => _locale = value;

  TranslateManager._();

  factory TranslateManager(BuildContext context) {
    _instance._locale = _instance._isLocaleOverrided
        ? _instance._locale
        : Localizations.localeOf(context);

    _instance._manageLocals = LocalizationsFiles();
    return _instance;
  }

  String getString(String _stringKey, {List<dynamic> params}) {
    final localeFile = _getLocaleFile(_stringKey);
    if (localeFile == null) return '';
    return _replacePatternToParams(localeFile[PluralsKey.none], params);
  }

  String getPlurals(String _stringKey, int _quantity, {List<dynamic> params}) {
    final PluralsKey _pluralsKey = _getPluralsKey(_quantity);
    final localeFile = _getLocaleFile(_stringKey);
    if (localeFile == null) return '';
    return _replacePatternToParams(localeFile[_pluralsKey], params);
  }

  String _getLocaleKey() {
    return (_locale.countryCode == null)
        ? '${_locale.languageCode}'
        : '${_locale.languageCode}_${_locale.countryCode}';
  }

  dynamic _getLocaleFile(String _stringKey) {
    final String _localeKey = _getLocaleKey();
    final localeFile = _manageLocals.files[_localeKey][_stringKey] ?? null;
    return localeFile;
  }

  PluralsKey _getPluralsKey(int _quantity) {
    switch (_quantity) {
      case 0:
        return PluralsKey.zero;
        break;
      case 1:
        return PluralsKey.one;
        break;
      default:
        return PluralsKey.other;
        break;
    }
  }

  String _replacePatternToParams(
      String textToReplace, List<dynamic> replaceParamList) {
    if (replaceParamList == null) return textToReplace;

    for (var i = 0; i < replaceParamList.length; i++) {
      final pattern = '@$i';
      textToReplace =
          textToReplace.replaceFirst(pattern, replaceParamList[i].toString());
    }

    return textToReplace;
  }
}

enum PluralsKey {
  none,
  zero,
  one,
  other,
}
