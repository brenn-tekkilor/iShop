import 'package:logger/logger.dart';

import 'const_log_filter.dart';

class ConstDevelopmentFilter extends ConstLogFilter {
  const ConstDevelopmentFilter({Level lvl = _defaultLevel}) : super(lvl: lvl);

  @override
  ConstLogFilter init() {
    return this;
  }

  @override
  bool shouldLog(LogEvent event) {
    var shouldLog = false;
    assert(() {
      if (event.level.index >= level.index) {
        shouldLog = true;
      }
      return true;
    }());
    return shouldLog;
  }

  static const _defaultLevel = Level.verbose;
}
