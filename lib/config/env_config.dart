import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {

  static Future<void> loadEnv() async {
    try {      
      String envFileName = ".env";
      await dotenv.load(fileName: envFileName);
    } catch (e) {
      rethrow;
    }
  }
}
