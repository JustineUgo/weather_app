import 'package:geolocator/geolocator.dart';
import 'package:weather/service/location_service.dart';

// Mock LocationService
class MockLocationService extends LocationService {
  final double latitude;
  final double longitude;
  final bool throwError;

  MockLocationService({
    this.latitude = 10.0,
    this.longitude = 20.0,
    this.throwError = false,
  });

  @override
 Future<Position> getCurrentPosition() async {
    if (throwError) throw Exception('Location error');

    return Position(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
      accuracy: 5.0,
      altitude: 10.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      altitudeAccuracy: 1.0,
      headingAccuracy: 1.0,
      isMocked: false,
    );
  }
}
