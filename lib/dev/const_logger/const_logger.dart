import 'package:ishop/dev/const_logger/console_logger.dart';
import 'package:ishop/dev/const_logger/const_console_output.dart';
import 'package:ishop/dev/const_logger/const_development_filter.dart';
import 'package:ishop/dev/const_logger/const_log_filter.dart';
import 'package:ishop/dev/const_logger/const_log_output.dart';
import 'package:ishop/dev/const_logger/const_log_printer.dart';
import 'package:logger/logger.dart';

/// Use instances of logger to send log messages to the [ConstLogPrinter].
class ConstLogger {
  /// Create a new instance of Logger.
  ///
  /// You can provide a custom [printer], [filter] and [output]. Otherwise the
  /// defaults: [ConsoleLogger] , [ConstDevelopmentFilter] and [ConstConsoleOutput] will be
  /// used.
  const ConstLogger({
    ConstLogFilter filter = _defaultDevelopmentFilter,
    ConstLogPrinter printer = _defaultLogPrinter,
    ConstLogOutput output = _defaultLogOutput,
    Level level = _defaultLevel,
  })  : _filter = filter,
        _printer = printer,
        _output = output;

  /// The current logging level of the app.
  ///
  /// All logs with levels below this level will be omitted.

  final ConstLogFilter _filter;
  final ConstLogPrinter _printer;
  final ConstLogOutput _output;

  StackTrace get stackTrace => StackTrace.current;

  /// Log a message at level [Level.verbose].
  void v(dynamic message, [dynamic error]) {
    log(Level.verbose, message, error);
  }

  /// Log a message at level [Level.debug].
  void d(dynamic message, [dynamic error]) {
    log(Level.debug, message, error);
  }

  /// Log a message at level [Level.info].
  void i(dynamic message, [dynamic error]) {
    log(Level.info, message, error);
  }

  /// Log a message at level [Level.warning].
  void w(dynamic message, [dynamic error]) {
    log(Level.warning, message, error);
  }

  /// Log a message at level [Level.error].
  void e(dynamic message, [dynamic error]) {
    log(Level.error, message, error);
  }

  /// Log a message at level [Level.wtf].
  void wtf(dynamic message, [dynamic error]) {
    log(Level.wtf, message, error);
  }

  /// Log a message with [level].
  void log(Level level, dynamic message, [dynamic error]) {
    if (error != null && error is StackTrace) {
      throw ArgumentError('Error parameter cannot take a StackTrace!');
    } else if (level == Level.nothing) {
      throw ArgumentError('Log events cannot have Level.nothing');
    }
    var logEvent = LogEvent(level, message, error, stackTrace);
    if (_filter.shouldLog(logEvent)) {
      var output = _printer.log(logEvent);

      if (output.isNotEmpty) {
        var outputEvent = OutputEvent(level, output);
        // Issues with log output should NOT influence
        // the main software behavior.
        try {
          _output.output(outputEvent);
        } catch (e, s) {
          print(e);
          print(s);
        }
      }
    }
  }

  /// Closes the logger and releases all resources.
  void close() {}

  static const _defaultLevel = Level.verbose;
  static const _defaultDevelopmentFilter =
      ConstDevelopmentFilter(lvl: Level.verbose);
  static const _defaultLogPrinter = ConsoleLogger();
  static const _defaultLogOutput = ConstConsoleOutput();
}
