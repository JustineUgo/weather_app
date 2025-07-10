import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/route/router.dart';
import 'package:weather/src/bloc/weather/weather_bloc.dart';
import 'package:weather/src/bloc/weather/weather_event.dart';
import 'package:weather/src/bloc/weather/weather_state.dart';
import 'package:weather/src/model/weather_response.dart';
import 'package:weather/src/screen/widget/weather_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<WeatherBloc>(context).add(
      LoadWeatherForCities([
        Coordinate(lat: 6.4550, lon: 3.3841), // Lagos
        Coordinate(lat: 9.0667, lon: 7.4833), // Abuja
        Coordinate(lat: 4.8242, lon: 7.0336), // Port Harcourt
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Weather Check!")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(CupertinoIcons.add),
        onPressed: () => context.push(RoutePath.city),
      ),
      body: SafeArea(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              return Center(
                child: CarouselSlider.builder(
                  itemCount: state.weatherList.length,
                  options: CarouselOptions(
                    height: 450.0,
                    viewportFraction: 0.75,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                  ),
                  itemBuilder: (context, index, realIdx) {
                    return WeatherTile(weather: state.weatherList[index]);
                  },
                ),
              );
            } else if (state is WeatherError) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
