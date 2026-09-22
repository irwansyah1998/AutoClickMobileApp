import 'dart:convert';

import 'package:autoclickmobileapp/data/models/click_configuration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsStorage {
  static const String _configKey = 'autoclick_config';
  static const String _loopModeKey = 'autoclick_loop_mode';
  static const String _themeKey = 'autoclick_theme';

  Future<void> saveConfiguration(ClickConfiguration config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_configKey, jsonEncode(config.toJson()));
  }

  Future<ClickConfiguration?> loadConfiguration() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_configKey);
    if (raw == null || raw.isEmpty) return null;

    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      return null;
    }

    return ClickConfiguration.fromJson(decoded);
  }

  Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode);
  }

  Future<String> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? 'system';
  }

  Future<void> saveLoopMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loopModeKey, mode);
  }

  Future<String> loadLoopMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_loopModeKey) ?? 'unlimited';
  }
}
