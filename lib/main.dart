import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/config/env_config.dart';
import 'package:weather/config/env_variables.dart';
import 'package:weather/route/router.dart';
import 'package:weather/service/network_service.dart';
import 'package:weather/service/storage_service.dart';
import 'package:weather/src/bloc/city/city_bloc.dart';
import 'package:weather/src/bloc/city/selected_city_bloc.dart';
import 'package:weather/src/bloc/weather/weather_bloc.dart';
import 'package:weather/src/repository/city_repository.dart';
import 'package:weather/src/repository/weather_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await EnvConfig.loadEnv();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(WeatherApp(sharedPreferences: sharedPreferences));
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key, required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final WeatherDioClient client = WeatherDioClient(
      Dio(
        BaseOptions(
          baseUrl: EnvVariables.baseURL,
          connectTimeout: const Duration(seconds: 20),
        ),
      ),
    );
    final storage = StorageService();
    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectedCityBloc>(
          create: (_) => SelectedCityBloc(
            storageService: storage,
            cityRepository: CityRepository(storageService: storage),
          ),
        ),
        BlocProvider(
          create: (_) => WeatherBloc(
            repository: WeatherRepositoryImpl(networkService: client),
          ),
        ),
        BlocProvider(
          create: (_) =>
              CityBloc(repository: CityRepository(storageService: storage)),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFF0E0E10),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF0E0E10),
            foregroundColor: Color(0xFFFFFFFF),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            foregroundColor: Color(0xFF0E0E10),
            backgroundColor: Color(0xFFFFFFFF),
          ),
        ),
        themeMode: ThemeMode.light,
        routerConfig: router,
      ),
    );
  }
}
