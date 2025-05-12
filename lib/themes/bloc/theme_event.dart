import 'package:mtaa_frontend/themes/bloc/theme_state.dart';

abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class ChangeThemeEvent extends ThemeEvent {
  final AppThemeMode newThemeMode;
  ChangeThemeEvent(this.newThemeMode);
}