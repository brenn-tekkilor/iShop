import 'package:flutter/animation.dart';
import 'package:ishop/com/interfaces/list_card.dart';

/// AnimatedListItem
abstract class AnimatedListCard<T extends Object> extends ListCard<T> {
  /// AnimatedListItem constructor
  const AnimatedListCard();

  /// animation
  Animation<double> get animation;
}
