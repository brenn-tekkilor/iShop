import 'package:ishop/dev/const_logger/const_level.dart';
import 'package:ishop/dev/const_logger/const_log_event.dart';
import 'package:ishop/dev/const_logger/const_log_filter.dart';

/// Const Development Filter
class ConstDevelopmentFilter extends ConstLogFilter {
  /// Const Development Filter default const constructor
  const ConstDevelopmentFilter({ConstLevel level = _defaultLevel})
      : super(level: level);
  @override
  bool shouldLog(ConstLogEvent event) => event.level.index >= level.index;

  static const _defaultLevel = ConstLevel.verbose;
}
