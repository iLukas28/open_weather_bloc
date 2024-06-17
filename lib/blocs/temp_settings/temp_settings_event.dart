part of 'temp_settings_bloc.dart';

sealed class TempSettingsEvent extends Equatable {
  const TempSettingsEvent();

  @override
  List<Object> get props => [];
}

class ToogleTempUnit extends TempSettingsEvent {
  final TempUnit tempUnit;

  const ToogleTempUnit({required this.tempUnit});
}
