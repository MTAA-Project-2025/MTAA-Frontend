import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(appThemeMode: AppThemeMode.light)) {
    on<ChangeThemeEvent>((event, emit) {
      emit(ThemeState(appThemeMode: event.newThemeMode));
    });
    on<ToggleThemeEvent>((event, emit) {
      final current = state.appThemeMode;
      AppThemeMode next;
      if (current == AppThemeMode.light) {
        next = AppThemeMode.dark;
      } else {
        next = AppThemeMode.light;
      }
      emit(ThemeState(appThemeMode: next));
    });
  }
}