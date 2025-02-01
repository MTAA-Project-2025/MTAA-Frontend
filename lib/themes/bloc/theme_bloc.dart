import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.light)) {
    on<ToggleThemeEvent>((event, emit) {
      final isDarkMode = state.themeMode == ThemeMode.dark;
      emit(ThemeState(themeMode: isDarkMode ? ThemeMode.light : ThemeMode.dark));
    });
  }
}