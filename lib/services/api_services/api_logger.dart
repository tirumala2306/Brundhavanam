import 'package:flutter/foundation.dart';

class ApiLogger {
  static void request(String method, Uri uri, {dynamic body}) {
    if (kDebugMode) {
      debugPrint("➡️ [$method] $uri");
      if (body != null) debugPrint("📦 Body: $body");
    }
  }

  static void response(int statusCode, String body) {
    if (kDebugMode) {
      debugPrint("⬅️ Status: $statusCode");
      debugPrint("📩 Response: $body");
    }
  }

  static void error(String message) {
    if (kDebugMode) {
      debugPrint("❌ Error: $message");
    }
  }
}
