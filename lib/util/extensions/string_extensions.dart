/// StringExtensions
extension StringExtensions on String {
  /// clipStart
  String clipStart(
          {int maxLength = 0, String leading = '', String trailing = ''}) =>
      _isClipEmpty(maxLength)
          ? '$leading$trailing'
          : maxLength > length
              ? '$leading${toString()}$trailing'
              : '$leading${substring(0, maxLength - 1)}$trailing';

  /// clipMid
  String clipMid(
      {int maxLength = 0, String leading = '', String trailing = ''}) {
    if (_isClipEmpty(maxLength)) {
      return '$leading$trailing';
    } else if (maxLength > length) {
      return '$leading${toString()}$trailing';
    } else {
      final a = length - maxLength;
      final b = (a / 2).floor();
      return '$leading${substring(b, a - b)}$trailing';
    }
  }

  /// clipEnd
  String clipEnd(
          {int maxLength = 0, String leading = '', String trailing = ''}) =>
      _isClipEmpty(maxLength)
          ? '$leading$trailing'
          : maxLength > length
              ? '$leading${toString()}$trailing'
              : '$leading${substring(length - maxLength, length - 1)}$trailing';

  bool _isClipEmpty(int value) => value == 0 || length == 0;
}
