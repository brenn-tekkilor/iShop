import 'dart:convert';
import 'dart:ui';

import 'package:ishop/dev/const_logger/const_ansi_color.dart';
import 'package:ishop/dev/const_logger/const_level.dart';
import 'package:ishop/dev/const_logger/const_log_event.dart';
import 'package:ishop/dev/const_logger/const_log_printer.dart';
import 'package:ishop/dev/const_logger/const_logger.dart';

/// Default implementation of [ConstLogPrinter].
///
/// Output looks like this:
/// ```
/// ┌──────────────────────────
/// │ Error info
/// ├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
/// │ Method stack history
/// ├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄
/// │ Log message
/// └──────────────────────────
/// ```
class ConsoleLogger extends ConstLogPrinter {
  /// default constructor
  const ConsoleLogger({
    this.className = _defaultName,
    this.methodCount = 0,
    this.errorMethodCount = 5,
    this.lineLength = 60,
    this.colors = true,
    this.printEmojis = true,
    this.printTime = false,
  });

  //#region properties
  /// method count
  final int methodCount;

  /// error method count
  final int errorMethodCount;

  /// line length
  final int lineLength;

  /// colors
  final bool colors;

  /// print emojis
  final bool printEmojis;

  /// print time
  final bool printTime;

  /// class name
  final String className;

  String get _topBorder => '$topLeftCorner$doubleDivider';
  String get _middleBorder => '$middleCorner$singleDivider';
  String get _bottomBorder => '$bottomLeftCorner$doubleDivider';
  //#endregion

  @override
  List<String> log(ConstLogEvent event) {
    final messageStr = stringifyMessage(event.message);
    var stackTraceStr = '';
    if (methodCount > 0) {
      stackTraceStr = formatStackTrace(StackTrace.current, methodCount);
    } else if (errorMethodCount > 0) {
      stackTraceStr = formatStackTrace(event.stackTrace, errorMethodCount);
    }
    final errorStr = event.error?.toString() ?? '';
    var timeStr = '';
    if (printTime) {
      timeStr = getTime();
    }
    return _formatAndPrint(
      event.level,
      className,
      messageStr,
      timeStr,
      errorStr,
      stackTraceStr,
    );
  }

  /// format stack trace
  String formatStackTrace(StackTrace stackTrace, int methodCount) {
    final lines = stackTrace.toString().split('\n');
    final formatted = <String>[];
    var count = 0;
    for (final line in lines) {
      if (_discardDeviceStacktraceLine(line) ||
          _discardWebStacktraceLine(line) ||
          _discardBrowserStacktraceLine(line)) {
        continue;
      }
      formatted.add('#$count   ${line.replaceFirst(RegExp(r'#\d+\s+'), '')}');
      if (++count == methodCount) {
        break;
      }
    }

    if (formatted.isEmpty) {
      return '';
    } else {
      return formatted.join('\n');
    }
  }

  bool _discardDeviceStacktraceLine(String line) {
    final match = _deviceStackTraceRegex.matchAsPrefix(line);
    if (match != null) {
      final g = match.group(2);
      if (g != null) {
        return g.startsWith('package:logger');
      }
    }
    return false;
  }

  bool _discardWebStacktraceLine(String line) {
    final match = _webStackTraceRegex.matchAsPrefix(line);
    if (match != null) {
      final g = match.group(1);
      if (g != null) {
        return g.startsWith('packages/logger') || g.startsWith('dart-sdk/lib');
      }
    }
    return false;
  }

  bool _discardBrowserStacktraceLine(String line) {
    final match = _browserStackTraceRegex.matchAsPrefix(line);
    if (match != null) {
      final g = match.group(1);
      if (g != null) {
        return g.startsWith('package:logger') || g.startsWith('dart:');
      }
    }
    return false;
  }

  /// get the current time
  String getTime() {
    String _threeDigits(int n) {
      if (n >= 100) {
        return '$n';
      }
      if (n >= 10) {
        return '0$n';
      }
      return '00$n';
    }

    String _twoDigits(int n) {
      if (n >= 10) {
        return '$n';
      }
      return '0$n';
    }

    final now = DateTime.now();
    final h = _twoDigits(now.hour);
    final min = _twoDigits(now.minute);
    final sec = _twoDigits(now.second);
    final ms = _threeDigits(now.millisecond);
    final timeSinceStart = now.difference(_startTime).toString();
    return '$h:$min:$sec.$ms (+$timeSinceStart)';
  }

  /// makes a message a string
  String stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }

  ConstAnsiColor? _getLevelColor(ConstLevel level) {
    if (colors) {
      return levelColors[level];
    } else {
      return const ConstAnsiColor.none();
    }
  }

  ConstAnsiColor _getErrorColor(ConstLevel level) {
    if (colors) {
      if (level == ConstLevel.wtf) {
        final w = levelColors[ConstLevel.wtf];
        if (w != null) {
          return w.toBg;
        }
      } else {
        final e = levelColors[ConstLevel.error];
        if (e != null) {
          return e.toBg;
        }
      }
    }
    return const ConstAnsiColor.none();
  }

  String _getEmoji(ConstLevel level) {
    if (printEmojis) {
      return levelEmojis[level] ?? '';
    } else {
      return '';
    }
  }

  List<String> _formatAndPrint(
    ConstLevel level,
    String className,
    String message,
    String time,
    String error,
    String stacktrace,
  ) {
    // This code is non trivial and a type annotation here helps understanding.
    // ignore: omit_local_variable_types
    final List<String> buffer = [];
    final color = _getLevelColor(level);
    if (color != null) {
      buffer.add(color(_topBorder));

      final errorColor = _getErrorColor(level);
      for (final line in error.split('\n')) {
        buffer.add(
          color('$verticalLine ') +
              errorColor.resetForeground +
              errorColor(line) +
              errorColor.resetBackground,
        );
      }
      buffer.add(color(_middleBorder));
    }

    for (final line in stacktrace.split('\n')) {
      buffer.add('$color$verticalLine $line');
    }
    if (color != null) {
      buffer
        ..add(color(_middleBorder))
        ..add(color('$verticalLine $time'))
        ..add(color(_middleBorder));
      final emoji = _getEmoji(level);
      for (final line in message.split('\n')) {
        buffer.add(color('$verticalLine $emoji $className - $line'));
      }
      buffer.add(color(_bottomBorder));
    }
    return buffer;
  }

  static final DateTime _startTime = DateTime.now();

  /// topLeftCorner
  static const topLeftCorner = '┌';

  /// bottom left corner
  static const bottomLeftCorner = '└';

  /// middle corner
  static const middleCorner = '├';

  /// vertical line
  static const verticalLine = '│';

  /// double divider line
  static const doubleDivider =
      '────────────────────────────────────────────────────────────';

  /// single divider line
  static const singleDivider =
      '┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄';

  /// colors for levels
  static final levelColors = <ConstLevel, ConstAnsiColor>{
    ConstLevel.verbose: ConstAnsiColor.fg(Color(ConstAnsiColor.grey(0.5))),
    ConstLevel.debug: const ConstAnsiColor.none(),
    ConstLevel.info: const ConstAnsiColor.fg(Color(0xFF000CFF)),
    ConstLevel.warning: const ConstAnsiColor.fg(Color(0xFFE17D7D)),
    ConstLevel.error: const ConstAnsiColor.fg(Color(0xFFC40000)),
    ConstLevel.wtf: const ConstAnsiColor.fg(Color(0xFFC400C8)),
  };

  /// emojis for levels
  static final levelEmojis = {
    ConstLevel.verbose: '',
    ConstLevel.debug: '🐛 ',
    ConstLevel.info: '💡 ',
    ConstLevel.warning: '⚠️ ',
    ConstLevel.error: '⛔ ',
    ConstLevel.wtf: '👾 ',
  };
  static const _defaultName = 'app';

  /// Matches a stacktrace line as generated on Android/iOS devices.
  /// For example:
  /// #1      Logger.log (package:logger/src/logger.dart:115:29)
  static final _deviceStackTraceRegex =
      RegExp(r'#[0-9]+[\s]+(.+) \(([^\s]+)\)');

  /// Matches a stacktrace line as generated by Flutter web.
  /// For example:
  /// packages/logger/src/printers/pretty_printer.dart 91:37
  static final _webStackTraceRegex =
      RegExp(r'^((packages|dart-sdk)\/[^\s]+\/)');

  /// Matches a stacktrace line as generated by browser Dart.
  /// For example:
  /// dart:sdk_internal
  /// package:logger/src/logger.dart
  static final _browserStackTraceRegex =
      RegExp(r'^(?:package:)?(dart:[^\s]+|[^\s]+)');

  /// get logger
  static ConstLogger getLogger({String className = 'app'}) =>
      ConstLogger(printer: ConsoleLogger(className: className));
}
