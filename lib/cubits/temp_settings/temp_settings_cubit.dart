// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'temp_settings_state.dart';

class TempSettingsCubit extends Cubit<TemperatureState> {
  TempSettingsCubit() : super(TemperatureState.initial());

  void toogleTempUnit() {
    emit(state.copyWith(
        tempUnit: state.tempUnit == TempUnit.celsius
            ? TempUnit.fahern
            : TempUnit.celsius));
  }
}
