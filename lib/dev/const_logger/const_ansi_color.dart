import 'dart:ui';

/// This class handles colorizing of terminal output.
class ConstAnsiColor {
  /// ConstAnsiColor default const constructor
  const ConstAnsiColor(
      {this.fgColor = _defaultFg,
      this.bgColor = _defaultBg,
      this.isColor = _defaultColor});

  /// none
  const ConstAnsiColor.none()
      : fgColor = null,
        bgColor = null,
        isColor = false;

  /// with fg
  const ConstAnsiColor.fg(this.fgColor)
      : bgColor = _defaultBg,
        isColor = true;

  /// with bg
  const ConstAnsiColor.bg(this.bgColor)
      : fgColor = null,
        isColor = true;

  /// ANSI Control Sequence Introducer, signals the terminal for new settings.
  static const ansiEsc = '\x1B[';

  /// Reset all colors and options for current SGRs to terminal defaults.
  static const ansiDefault = '${ansiEsc}0m';

  /// foreground color
  final Color? fgColor;

  /// background color;
  final Color? bgColor;

  /// color
  final bool isColor;

  /// foreground value
  int? get fg => fgColor?.value;

  /// background value
  int? get bg => bgColor?.value;

  @override
  String toString() {
    if (fg != null) {
      return '${ansiEsc}38;5;${fg}m';
    } else if (bg != null) {
      return '${ansiEsc}48;5;${bg}m';
    } else {
      return '';
    }
  }

  /// call
  String call(String msg) {
    if (isColor) {
      return '${this}$msg$ansiDefault';
    } else {
      return msg;
    }
  }

  /// to foreground
  ConstAnsiColor get toFg => ConstAnsiColor.fg(bgColor);

  /// to background
  ConstAnsiColor get toBg => ConstAnsiColor.bg(fgColor);

  /// Defaults the terminal's foreground color without altering the background.
  String get resetForeground => isColor ? '${ansiEsc}39m' : '';

  /// Defaults the terminal's background color without altering the foreground.
  String get resetBackground => isColor ? '${ansiEsc}49m' : '';

  /// gets grey
  static int grey(double level) => 232 + (level.clamp(0.0, 1.0) * 23).round();
  static const _defaultBg = Color(0xFFFFFFFF);
  static const _defaultFg = Color(0xFF000000);
  static const _defaultColor = true;
}
