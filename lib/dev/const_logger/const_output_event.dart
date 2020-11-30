import 'package:ishop/dev/const_logger/const_level.dart';

/// const output event
class ConstOutputEvent {
  /// const output event default const constructor
  const ConstOutputEvent({required this.level, required this.lines});

  /// level
  final ConstLevel level;

  /// lines
  final List<String> lines;
}
