import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._preferences) : super(_read(_preferences));

  static const _key = 'theme_mode';
  final SharedPreferences _preferences;

  Future<void> setMode(ThemeMode mode) async {
    emit(mode);
    await _preferences.setString(_key, mode.name);
  }

  static ThemeMode _read(SharedPreferences preferences) {
    final value = preferences.getString(_key);
    for (final mode in ThemeMode.values) {
      if (mode.name == value) return mode;
    }
    return ThemeMode.system;
  }
}
