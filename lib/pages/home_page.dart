// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_bloc/blocs/temp_settings/temp_settings_bloc.dart';
import 'package:open_weather_bloc/blocs/weather/weather_bloc.dart';
import 'package:open_weather_bloc/constants/constants.dart';
import 'package:open_weather_bloc/pages/search_page.dart';
import 'package:open_weather_bloc/pages/settins_page.dart';
import 'package:open_weather_bloc/widgets/error_dialog.dart';
import 'package:recase/recase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Weather'),
          actions: [
            IconButton(
                onPressed: () async {
                  city = await Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const SearchPage();
                    },
                  ));
                  if (city != null) {
                    // ignore: use_build_context_synchronously
                    context
                        .read<WeatherBloc>()
                        .add(FetchWeatherEvent(city: city!));
                  }
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const SettingsPage();
                    },
                  ));
                },
                icon: const Icon(Icons.settings)),
          ],
        ),
        body: _showWeather());
  }

  String showTemperature(double temperature) {
    final tempUnit = context.watch<TempSettingsBloc>().state.tempUnit;
    if (tempUnit == TempUnit.fahern) {
      return '${((temperature * 9) / 5 + 32).toStringAsFixed(2)} ℉';
    }
    return '${temperature.toStringAsFixed(2)} ℃';
  }

  Widget _showWeather() {
    return BlocConsumer<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state.status == WeatherStatus.initial) {
          return const Center(child: Text('Select a city'));
        }
        if (state.status == WeatherStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.status == WeatherStatus.error && state.weather.name == '') {
          return const Center(child: Text('Select a city'));
        }
        return ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Text(
              state.weather.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(TimeOfDay.fromDateTime(state.weather.lastUpdated)
                    .format(context)),
                const SizedBox(
                  width: 10,
                ),
                Text('(${state.weather.country})')
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  showTemperature(state.weather.temp),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    Text(showTemperature(state.weather.tempMax)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(showTemperature(state.weather.tempMin))
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Spacer(),
                showIcon(state.weather.icon),
                Text(
                  state.weather.description.titleCase,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer()
              ],
            ),
          ],
        );
      },
      listener: (context, state) {
        if (state.status == WeatherStatus.error) {
          errorDialog(context, state.error.errorMsg);
        }
      },
    );
  }

  Widget showIcon(String icon) {
    return FadeInImage.assetNetwork(
        width: 96,
        height: 96,
        placeholder: 'assets/images/loading.gif',
        image: 'http://$kIconHost/img/wn/$icon@4x.png');
  }
}
