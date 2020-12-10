import 'package:ishop/com/interfaces/fire_doc.dart';
import 'package:ishop/com/interfaces/list_item.dart';

/// FireListItem
abstract class FireListItem<T extends FireDoc> extends ListItem<T> {
  /// FireListItem constructor
  const FireListItem();
}
