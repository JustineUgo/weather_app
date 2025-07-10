import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/route/router.dart';
import 'package:weather/src/bloc/city/selected_city_bloc.dart';
import 'package:weather/src/bloc/city/selected_city_event.dart';
import 'package:weather/src/bloc/city/selected_city_state.dart';
import 'package:weather/src/bloc/weather/my_weather_bloc.dart';
import 'package:weather/src/bloc/weather/weather_bloc.dart';
import 'package:weather/src/bloc/weather/weather_event.dart';
import 'package:weather/src/bloc/weather/weather_state.dart';
import 'package:weather/src/screen/widget/weather_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController controller = CarouselController();
  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // React to selected cities and load weather
    BlocProvider.of<SelectedCityBloc>(context).stream.listen((state) {
      if (state is SelectedCityLoaded) {
        final coords = state.cities
            .map((c) => Coordinate(lat: c.lat ?? 0, lon: c.lng ?? 0))
            .toList();

        // ignore: use_build_context_synchronously
        BlocProvider.of<WeatherBloc>(context).add(LoadWeatherForCities(coords));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<SelectedCityBloc>(context).add(LoadSelectedCities());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Weather Check!"),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.location),
            onPressed: () {
              BlocProvider.of<MyWeatherBloc>(context).add(LoadWeatherForCurrentLocation());
              context.push(RoutePath.myWeather);
            },
          ),
        ],
      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(state.weatherList.length, (
                        index,
                      ) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          width: currentIndex == index ? 12 : 8,
                          height: currentIndex == index ? 12 : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentIndex == index
                                ? Color(0xFFeeeee4)
                                : Colors.grey,
                          ),
                        );
                      }),
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
