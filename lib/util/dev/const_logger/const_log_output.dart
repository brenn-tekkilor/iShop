import 'package:logger/src/logger.dart';

/// Log output receives a [OutputEvent] from [LogPrinter] and sends it to the
/// desired destination.
///
/// This can be an output stream, a file or a network target. [LogOutput] may
/// cache multiple log messages.
abstract class ConstLogOutput {
  const ConstLogOutput();
  void init() {}

  void output(OutputEvent event);

  void destroy() {}
}