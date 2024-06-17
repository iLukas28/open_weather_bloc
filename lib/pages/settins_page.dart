import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_bloc/blocs/temp_settings/temp_settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListTile(
          title: const Text('Temperature Unit'),
          subtitle: const Text('C/F: Default Celsius'),
          trailing: Switch(
              value: context.watch<TempSettingsBloc>().state.tempUnit ==
                  TempUnit.celsius,
              onChanged: (value) {
                context.read<TempSettingsBloc>().add(ToogleTempUnit(
                    tempUnit: value ? TempUnit.celsius : TempUnit.fahern));
              }),
        ),
      ),
    );
  }
}
