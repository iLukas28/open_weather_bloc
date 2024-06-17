part of 'temp_settings_bloc.dart';

enum TempUnit { celsius, fahern }

class TemperatureState extends Equatable {
  final TempUnit tempUnit;

  const TemperatureState({this.tempUnit = TempUnit.celsius});

  factory TemperatureState.initial() {
    return const TemperatureState();
  }

  @override
  String toString() => 'TemperatureState(tempUnit: $tempUnit)';

  TemperatureState copyWith({
    TempUnit? tempUnit,
  }) {
    return TemperatureState(
      tempUnit: tempUnit ?? this.tempUnit,
    );
  }

  @override
  List<Object> get props => [tempUnit];
}
