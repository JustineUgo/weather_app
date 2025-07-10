import 'dart:developer';
import 'package:flutter/foundation.dart';

class LogService {
  static void logDebug(String message) {
    if (kDebugMode) {
      log(message);
    }
  }
}