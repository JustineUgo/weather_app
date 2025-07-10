import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/src/bloc/city/city_bloc.dart';
import 'package:weather/src/bloc/city/city_event.dart';
import 'package:weather/src/bloc/city/city_state.dart';
import 'package:weather/src/bloc/city/selected_city_bloc.dart';
import 'package:weather/src/bloc/city/selected_city_event.dart';
import 'package:weather/src/bloc/city/selected_city_state.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CityBloc>(context).add(LoadCitiesEvent());
    BlocProvider.of<SelectedCityBloc>(context).add(LoadSelectedCities());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select City')),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<CityBloc, CityState>(
          builder: (context, cityState) {
            if (cityState is CityLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (cityState is CityLoaded) {
              final cities = cityState.cities.take(15).toList();
              return BlocBuilder<SelectedCityBloc, SelectedCityState>(
                builder: (context, selectedState) {
                  if (selectedState is SelectedCityLoaded) {
                    final selectedCities = selectedState.cities;
                    final selectedCityNames = selectedCities
                        .map((c) => c.city)
                        .toSet();

                    return ListView.builder(
                      itemCount: cities.length,
                      itemBuilder: (context, index) {
                        final city = cities[index];
                        final isSelected = selectedCityNames.contains(
                          city.city,
                        );
                        final isPermanent = selectedCities
                            .take(3)
                            .any((c) => c.city == city.city);

                        return ListTile(
                          leading: Text("${index + 1}"),
                          title: Text(
                            city.city ?? '',
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(city.adminName ?? ''),
                          trailing: isSelected
                              ? IconButton(
                                  icon: Icon(
                                    isPermanent
                                        ? CupertinoIcons
                                              .check_mark_circled_solid
                                        : CupertinoIcons.minus_circled,
                                    color: isPermanent
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  onPressed: isPermanent
                                      ? () {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "${city.city} is a default city",
                                              ),
                                            ),
                                          );
                                        }
                                      : () {
                                          context.read<SelectedCityBloc>().add(
                                            RemoveCityFromSelection(city),
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "${city.city} has been removed!",
                                              ),
                                            ),
                                          );
                                        },
                                )
                              : IconButton(
                                  icon: const Icon(CupertinoIcons.add_circled),
                                  onPressed: () {
                                    context.read<SelectedCityBloc>().add(
                                      AddCityToSelection(city),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          "${city.city} has been added!",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        );
                      },
                    );
                  } else if (selectedState is SelectedCityError) {
                    return Center(
                      child: Text(
                        selectedState.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              );
            } else if (cityState is CityError) {
              return Center(
                child: Text(
                  cityState.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.redAccent),
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
