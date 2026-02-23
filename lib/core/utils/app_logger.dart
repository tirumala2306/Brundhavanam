import 'dart:developer';

//AppLogger.info("API Called");
// AppLogger.error("API failed", error: e, stackTrace: s);

class AppLogger {
  static void info(String message, {String tag = 'INFO'}) {
    log(message, name: tag);
  }

  static void error(String message,
      {Object? error, StackTrace? stackTrace, String tag = 'ERROR'}) {
    log(
      message,
      name: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void warning(String message, {String tag = 'WARNING'}) {
    log(message, name: tag);
  }

  static void debug(String message, {String tag = 'DEBUG'}) {
    log(message, name: tag);
  }
}
