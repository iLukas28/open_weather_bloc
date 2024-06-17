import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_bloc/constants/constants.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeCubitBloc extends Bloc<ThemeCubitEvent, ThemeState> {
  ThemeCubitBloc() : super(ThemeState.initial()) {
    on<SetTheme>(_setTheme);
  }

  FutureOr<void> _setTheme(SetTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(appTheme: event.appTheme));
  }

  void setTemp(double currentTemp) {
    if (currentTemp > kWarmOrNot) {
      add(const SetTheme(appTheme: AppTheme.light));
    } else {
      add(const SetTheme(appTheme: AppTheme.dark));
    }
  }
}
