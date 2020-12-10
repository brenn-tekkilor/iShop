import 'dart:ui';

import 'package:ishop/com/interfaces/list_item.dart';

/// ListCard
abstract class ListCard<T extends Object> extends ListItem<T> {
  /// ListCard constructor
  const ListCard();

  /// color
  Color get color;

  /// logoPath
  String get logoPath;

  /// onTap
  VoidCallback get onTap;

  /// subtitle
  String get subtitle;

  /// title
  String get title;

  /// selected
  bool get isSelected;
}
