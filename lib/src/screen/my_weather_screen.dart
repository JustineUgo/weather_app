import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/bloc/weather/my_weather_bloc.dart';
import 'package:weather/src/bloc/weather/weather_event.dart';
import 'package:weather/src/bloc/weather/weather_state.dart';
import 'package:weather/src/screen/widget/weather_tile.dart';

class MyWeatherScreen extends StatefulWidget {
  const MyWeatherScreen({super.key});

  @override
  State<MyWeatherScreen> createState() => _MyWeatherScreenState();
}

class _MyWeatherScreenState extends State<MyWeatherScreen> {
  final CarouselController controller = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    BlocProvider.of<MyWeatherBloc>(
      context,
    ).add(LoadWeatherForCurrentLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My location Weather")),
      body: SafeArea(
        child: BlocBuilder<MyWeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CarouselSlider.builder(
                      itemCount: state.weatherList.length,
                      options: CarouselOptions(
                        height: 450.0,
                        viewportFraction: 0.75,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.2,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                      itemBuilder: (context, index, realIdx) {
                        return WeatherTile(weather: state.weatherList[index]);
                      },
                    ),
                  ],
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
