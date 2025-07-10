import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/config/env_config.dart';
import 'package:weather/route/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await EnvConfig.loadEnv();
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final WeatherDioClient client = WeatherDioClient(
    //   Dio(
    //     BaseOptions(
    //       baseUrl: EnvVariables.baseURL,
    //       connectTimeout: const Duration(seconds: 20),
    //     ),
    //   ),
    // );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF0E0E10),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0E0E10),
          foregroundColor: Color(0xFFFFFFFF),
        ),
      ),
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
