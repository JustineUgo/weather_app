import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/route/router.dart';
import 'package:weather/src/model/weather_response.dart';
import 'package:weather/src/screen/widget/weather_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        child: Center(
          child: CarouselSlider(
            options: CarouselOptions(
              height: 450.0,
              viewportFraction: 0.75,
              enlargeCenterPage: true,
              enlargeFactor: 0.2,
              initialPage: 0,
              enableInfiniteScroll: false,
            ),
            items: [1, 2, 3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return WeatherTile(weather: WeatherResponse.fixture());
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
