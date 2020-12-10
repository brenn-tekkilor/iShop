import 'package:ishop/com/interfaces/animated_list_card.dart';
import 'package:ishop/com/interfaces/fire_doc.dart';

/// FireAnimatedListCard
abstract class FireAnimatedListCard<T extends FireDoc>
    extends AnimatedListCard<T> {
  /// FireAnimatedListCard constructor
  const FireAnimatedListCard();
}
