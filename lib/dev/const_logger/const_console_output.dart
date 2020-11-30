import 'package:ishop/dev/const_logger/console_logger.dart';
import 'package:ishop/dev/const_logger/const_log_output.dart';
import 'package:ishop/dev/const_logger/const_output_event.dart';

/// Const Console Output
class ConstConsoleOutput extends ConstLogOutput {
  /// Const Console Output default const constructor
  const ConstConsoleOutput();

  /// logger
  static const logger = ConsoleLogger(className: 'ConstConsoleOutput');
  @override
  void output(ConstOutputEvent event) => logger.log;
}
