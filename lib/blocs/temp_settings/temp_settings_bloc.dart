import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_event.dart';
part 'temp_settings_state.dart';

class TempSettingsBloc extends Bloc<TempSettingsEvent, TemperatureState> {
  TempSettingsBloc() : super(TemperatureState.initial()) {
    on<ToogleTempUnit>(_toogleTempUnit);
  }

  FutureOr<void> _toogleTempUnit(
      ToogleTempUnit event, Emitter<TemperatureState> emit) {
    emit(state.copyWith(
        tempUnit: state.tempUnit == TempUnit.celsius
            ? TempUnit.fahern
            : TempUnit.celsius));
  }
}
