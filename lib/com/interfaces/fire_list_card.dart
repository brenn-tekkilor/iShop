import 'package:ishop/com/interfaces/fire_doc.dart';
import 'package:ishop/com/interfaces/list_card.dart';

/// FireListCard
abstract class FireListCard<T extends FireDoc> extends ListCard<T> {
  /// FireListCard constructor
  const FireListCard();
}
