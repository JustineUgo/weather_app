import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/bloc/city/city_bloc.dart';
import 'package:weather/src/bloc/city/city_event.dart';
import 'package:weather/src/bloc/city/city_state.dart';
import 'package:weather/src/model/city_model.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  List<String> defaultCities = ["Lagos", "Abuja", "Port Harcourt"];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CityBloc>(context).add(LoadCitiesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select City')),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<CityBloc, CityState>(
          builder: (context, state) {
            if (state is CityLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CityLoaded) {
              return ListView.builder(
                itemCount: state.cities.take(15).length,
                itemBuilder: (context, index) {
                  CityModel city = state.cities.take(15).toList()[index];
                  bool isDefault = defaultCities.contains(city.city);
                  return ListTile(
                    leading: Text("${index + 1}"),
                    title: Text(
                      city.city ?? '',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(city.adminName ?? ''),
                    trailing: isDefault
                        ? null
                        : Icon(CupertinoIcons.add_circled),
                  );
                },
              );
            } else if (state is CityError) {
              return Center(
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
