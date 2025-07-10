import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/src/bloc/weather/my_weather_bloc.dart';
import 'package:weather/src/bloc/weather/weather_event.dart';
import 'package:weather/src/bloc/weather/weather_state.dart';


import '../../mock/mock_location_service.dart';
import '../../mock/mock_weather_repository.dart';


void main() {
  late MyWeatherBloc bloc;
  late MockLocationService mockLocationService;
  late MockWeatherRepository mockWeatherRepository;

  final sampleApiResponse = {
    "temp": 25,
    "weather": [
      {"main": "Clear", "description": "clear sky"}
    ],
  };


  setUp(() {
    mockLocationService = MockLocationService();
    mockWeatherRepository = MockWeatherRepository(response: sampleApiResponse);
    bloc = MyWeatherBloc(
      locationService: mockLocationService,
      repository: mockWeatherRepository,
    );
  });

  test('initial state is WeatherInitial', () {
    expect(bloc.state, WeatherInitial());
  });

blocTest<MyWeatherBloc, WeatherState>(
  'emits [WeatherLoading, WeatherLoaded] when LoadWeatherForCurrentLocation succeeds',
  build: () => bloc,
  act: (bloc) => bloc.add(LoadWeatherForCurrentLocation()),
  expect: () => [
    isA<WeatherLoading>(),
    isA<WeatherLoaded>(),
  ],
);

  blocTest<MyWeatherBloc, WeatherState>(
    'emits [WeatherLoading, WeatherError] when LocationService throws',
    build: () {
      mockLocationService = MockLocationService(throwError: true);
      return MyWeatherBloc(
        locationService: mockLocationService,
        repository: mockWeatherRepository,
      );
    },
    act: (bloc) => bloc.add(LoadWeatherForCurrentLocation()),
    expect: () => [
      WeatherLoading(),
      isA<WeatherError>(),
    ],
  );

  blocTest<MyWeatherBloc, WeatherState>(
    'emits [WeatherLoading, WeatherError] when WeatherRepository throws',
    build: () {
      mockWeatherRepository = MockWeatherRepository(throwError: true);
      return MyWeatherBloc(
        locationService: mockLocationService,
        repository: mockWeatherRepository,
      );
    },
    act: (bloc) => bloc.add(LoadWeatherForCurrentLocation()),
    expect: () => [
      WeatherLoading(),
      isA<WeatherError>(),
    ],
  );
}
