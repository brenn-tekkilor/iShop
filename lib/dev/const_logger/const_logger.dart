import 'package:ishop/dev/const_logger/console_logger.dart';
import 'package:ishop/dev/const_logger/const_console_output.dart';
import 'package:ishop/dev/const_logger/const_development_filter.dart';
import 'package:ishop/dev/const_logger/const_level.dart';
import 'package:ishop/dev/const_logger/const_log_event.dart';
import 'package:ishop/dev/const_logger/const_log_filter.dart';
import 'package:ishop/dev/const_logger/const_log_output.dart';
import 'package:ishop/dev/const_logger/const_log_printer.dart';
import 'package:ishop/dev/const_logger/const_output_event.dart';

/// Use instances of logger to send log messages to the [ConstLogPrinter].
class ConstLogger {
  /// Create a new instance of Logger.
  ///
  /// You can provide a custom [printer], [filter] and [output]. Otherwise the
  /// defaults: [ConsoleLogger] , [ConstDevelopmentFilter]
  /// and [ConstConsoleOutput] will be used
  const ConstLogger({
    ConstLogFilter filter = _defaultDevelopmentFilter,
    ConstLogPrinter printer = _defaultLogPrinter,
    ConstLogOutput output = _defaultLogOutput,
  })  : _filter = filter,
        _printer = printer,
        _output = output;

  /// The current logging level of the app.
  ///
  /// All logs with levels below this level will be omitted.

  final ConstLogFilter _filter;
  final ConstLogPrinter _printer;
  final ConstLogOutput _output;

  /// stackTrace
  StackTrace get stackTrace => StackTrace.current;

  /// Log a message at level [ConstLevel.verbose].
  void v(String message, [Error? error]) {
    log(ConstLevel.verbose, message, error);
  }

  /// Log a message at level [ConstLevel.debug].
  void d(String message, [Error? error]) {
    log(ConstLevel.debug, message, error);
  }

  /// Log a message at level [ConstLevel.info].
  void i(String message, [Error? error]) {
    log(ConstLevel.info, message, error);
  }

  /// Log a message at level [ConstLevel.warning].
  void w(String message, [Error? error]) {
    log(ConstLevel.warning, message, error);
  }

  /// Log a message at level [ConstLevel.error].
  void e(String message, [Error? error]) {
    log(ConstLevel.error, message, error);
  }

  /// Log a message at level [ConstLevel.wtf].
  void wtf(String message, [Error? error]) {
    log(ConstLevel.wtf, message, error);
  }

  /// Log a message with [level].
  void log(ConstLevel level, String message, [Error? error]) {
    if (error != null && error is StackTrace) {
      throw ArgumentError('Error parameter cannot take a StackTrace!');
    } else if (level == ConstLevel.nothing) {
      throw ArgumentError('Log events cannot have Level.nothing');
    }
    final logEvent = ConstLogEvent(level, message, error, stackTrace);
    if (_filter.shouldLog(logEvent)) {
      final output = _printer.log(logEvent);

      if (output.isNotEmpty) {
        final outputEvent = ConstOutputEvent(level: level, lines: output);
        // Issues with log output should NOT influence
        // the main software behavior.
        _output.output(outputEvent);
      }
    }
  }

  /// Closes the logger and releases all resources.
  void close() {}

  static const _defaultDevelopmentFilter = ConstDevelopmentFilter();
  static const _defaultLogPrinter = ConsoleLogger();
  static const _defaultLogOutput = ConstConsoleOutput();
}
