import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Keeps a Dart [List] in sync with an [AnimatedList].
///
/// The [insert] and [removeAt] methods apply to both the internal list and
/// the animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that
/// mutate the list must make the same changes to the animated list in terms
/// of [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _initialItems = List<E>.from(initialItems ?? <E>[]),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _initialItems;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (BuildContext context, Animation<double> animation) =>
            removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  List<E> get initialItems => _initialItems;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

class CardItem extends StatelessWidget {
  const CardItem(
      {Key key, this.onTap, @required this.data, this.selected = false})
      : assert(data != null),
        super(key: key);

  final VoidCallback onTap;
  final CardItemData data;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    var titleTextStyle = Theme.of(context).textTheme.headline6;
    var subtitleTextStyle = Theme.of(context).textTheme.caption;
    if (selected) {
      titleTextStyle =
          titleTextStyle.copyWith(color: Colors.lightGreenAccent[400]);
      subtitleTextStyle =
          subtitleTextStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: 104,
          child: Card(
            color: data.subtitle == 'marketplace' ? Colors.green : Colors.grey,
            child: Center(
              child: Text(data.title, style: titleTextStyle),
            ),
          ),
        ),
      ),
    );
  }
}

class CardItemData {
  CardItemData({@required this.title, @required this.subtitle})
      : assert(title != null),
        assert(subtitle != null);

  final String title;
  final String subtitle;
}
