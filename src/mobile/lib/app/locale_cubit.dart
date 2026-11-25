import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._preferences)
    : super(Locale(_preferences.getString(_key) ?? 'en'));

  static const _key = 'locale';
  final SharedPreferences _preferences;

  Future<void> setLocale(Locale locale) async {
    emit(locale);
    await _preferences.setString(_key, locale.languageCode);
  }
}
