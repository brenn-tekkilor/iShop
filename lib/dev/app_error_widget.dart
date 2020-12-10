import 'package:flutter/widgets.dart';

/// AppErrorWidget
abstract class AppErrorWidget {
  /// create
  static Widget create(Object exception, StackTrace stackTrace) {
    final details = FlutterErrorDetails(
      exception: exception,
      stack: stackTrace,
      library: 'widgets library',
      context: ErrorDescription('building'),
    );
    FlutterError.reportError(details);
    return ErrorWidget.builder(details);
  }
}
