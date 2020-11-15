import 'package:tuple/tuple.dart';

enum SubRangePosition {
  start,
  middle,
  end,
}

typedef SubRangePositionFinder = Tuple2<int, int> Function(
    int inputLength, int rangeLength);

class StringClipperOptions {
  const StringClipperOptions(
      {int maxLength = 0,
      SubRangePosition position = SubRangePosition.start,
      String leading = '',
      String trailing = ''})
      : _maxLength = maxLength,
        _position = position,
        _leading = leading,
        _trailing = trailing;
  final int _maxLength;
  int get maxLength => _maxLength;
  final SubRangePosition _position;
  SubRangePosition get position => _position;
  final String _leading;
  String get leading => _leading;
  final String _trailing;
  String get trailing => _trailing;
}

extension StringClipperExtension on String {
  static const Map<SubRangePosition, SubRangePositionFinder>
      _subRangePositionFinderMap = <SubRangePosition, SubRangePositionFinder>{
    SubRangePosition.start: _startFinder,
    SubRangePosition.middle: _middleFinder,
    SubRangePosition.end: _endFinder,
  };
  static Tuple2<int, int> _middleFinder(int inputLength, int rangeLength) {
    final d = inputLength - rangeLength;
    final f = (d / 2).floor();
    return Tuple2(f, (d - f));
  }

  static Tuple2<int, int> _startFinder(int inputLength, int rangeLength) {
    return Tuple2(0, (rangeLength - 1));
  }

  static Tuple2<int, int> _endFinder(int inputLength, int rangeLength) {
    return Tuple2((inputLength - rangeLength), (inputLength - 1));
  }

  String clip(
      {String value = '', StringClipperOptions options = _defaultOptions}) {
    final subValue = _clipValue(value, options.maxLength,
        _subRangePositionFinderMap[options.position]!);
    return options.leading + subValue + options.trailing;
  }

  static String _clipValue(
      String value, int maxLength, SubRangePositionFinder finder) {
    final l = value.length;
    if (maxLength == 0 || l == 0) {
      return '';
    }
    if (l < maxLength) {
      return value;
    }
    final i = finder(l, maxLength);
    return value.substring(i.item1, i.item2);
  }

  static const _defaultOptions = StringClipperOptions();
}
