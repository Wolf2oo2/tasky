import 'package:flutter/material.dart';

import '../services/preferences_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  init() {
    bool res = PreferencesManager().getBool("theme") ?? true;
    themeNotifier.value = res ? ThemeMode.dark : ThemeMode.light;
  }

  static toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PreferencesManager().setBool("theme", false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferencesManager().setBool("theme", true);
    }
  }
  static bool isLight()=>themeNotifier.value==ThemeMode.light;
}
