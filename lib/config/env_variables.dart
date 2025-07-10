import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvVariables {
  static String baseURL = dotenv.env['BASE_URL']!;
}