import 'package:ishop/util/dev/const_logger/const_log_output.dart';
import 'package:logger/logger.dart';

class ConstConsoleOutput extends ConstLogOutput {
  const ConstConsoleOutput();
  @override
  void output(OutputEvent event) {
    event.lines.forEach(print);
  }
}
