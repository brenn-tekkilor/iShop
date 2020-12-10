/// ListItem
abstract class ListItem<T extends Object> {
  /// ListItem constructor
  const ListItem();

  /// item
  T get item;

  /// index
  int get index;
}
