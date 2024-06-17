import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_bloc/constants/constants.dart';
import 'package:open_weather_bloc/cubits/weather/weather_cubit.dart';

part 'theme_cubit_state.dart';

class ThemeCubitCubit extends Cubit<ThemeState> {
  late final StreamSubscription weatherSubscription;

  final WeatherCubit weatherCubit;
  ThemeCubitCubit({required this.weatherCubit}) : super(ThemeState.initial()) {
    weatherSubscription =
        weatherCubit.stream.listen((WeatherState weatherState) {
      if (weatherState.weather.temp > kWarmOrNot) {
        emit(state.copyWith(appTheme: AppTheme.light));
      } else {
        emit(state.copyWith(appTheme: AppTheme.dark));
      }
    });
  }
  @override
  Future<void> close() {
    weatherSubscription.cancel();
    return super.close();
  }
}
