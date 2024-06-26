// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:open_weather_bloc/models/custom_error.dart';
import 'package:open_weather_bloc/models/weather.dart';
import 'package:open_weather_bloc/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    emit(state.copyWith(status: WeatherStatus.loading));
    try {
      final Weather weather = await weatherRepository.fetchWeather(city);
      emit(state.copyWith(status: WeatherStatus.loaded, weather: weather));
    } on CustomError catch (e) {
      emit(state.copyWith(
          status: WeatherStatus.error,
          error: CustomError(errorMsg: e.toString())));
    }
  }
}
