part of 'theme_bloc.dart';

sealed class ThemeCubitEvent extends Equatable {
  const ThemeCubitEvent();

  @override
  List<Object> get props => [];
}

class SetTheme extends ThemeCubitEvent {
  final AppTheme appTheme;

  const SetTheme({required this.appTheme});
}
