import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:ishop/model/list_model.dart';
import 'package:ishop/utils/util.dart';

class LocationsListScroll extends StatefulWidget {
  LocationsListScroll(this.filterValue);
  int filterValue;
  @override
  _LocationsListScrollState createState() =>
      _LocationsListScrollState(filterValue);
}

class _LocationsListScrollState extends State<LocationsListScroll> {
  _LocationsListScrollState(int filterValue) {
    _bannerFilterActions.addAll([
      IconButton(
          key: ValueKey(0),
          icon: Icon(FrinoIcons.f_infinity),
          onPressed: () {
            setState(() {
              _filterAction = ValueNotifier(1);
            });
            FilterActionNotification(value: 1)..dispatch(context);
          }),
      IconButton(
          key: ValueKey(1),
          icon: Icon(FrinoIcons.f_shop),
          onPressed: () {
            setState(() {
              _filterAction = ValueNotifier(2);
            });
            FilterActionNotification(value: 2)..dispatch(context);
          }),
      IconButton(
          key: ValueKey(2),
          icon: Icon(FrinoIcons.f_basket),
          onPressed: () {
            setState(() {
              _filterAction = ValueNotifier(0);
            });
            FilterActionNotification(value: 0)..dispatch(context);
          }),
    ]);
    _filterAction = ValueNotifier(filterValue);
  }

  final listKey = GlobalKey<AnimatedListState>();
  final _cards = <CardItem>{};
  final _marketplaceCards = <CardItem>{};
  final _foodAndDrugCards = <CardItem>{};
  final _bannerFilterActions = <IconButton>[];
  Set<CardItem> visibleCards;
  CardItem _selectedCard;
  ValueListenable<int> _filterAction;

  Future<bool> _initializeRetailLocationList() async {
    final collection = FirebaseFirestore.instance.collection('retaillocations');
    await collection.get().then((value) async {
      final queryResult = await value;
      queryResult.docs.forEach((d) {
        final data = d.data();
        final name = data['n'];
        final banner = data['b'];
        final card = CardItem(
            key: ValueKey(d.id),
            data: CardItemData(title: name, subtitle: banner));
        _cards.add(card);
        if (banner == 'marketplace') {
          _marketplaceCards.add(card);
        } else {
          _foodAndDrugCards.add(card);
        }
      });
    }).catchError((e) => print(e));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _initializeRetailLocationList(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong: ${snapshot.error.toString()}');
          }
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return Text('Loading');
          }
          return Container(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
                initialChildSize: 0.1,
                minChildSize: 0.1,
                maxChildSize: 0.7,
                expand: true,
                builder: (context, scrollController) {
                  return CustomScrollView(
                    controller: scrollController,
                    scrollDirection: Axis.vertical,
                    slivers: <Widget>[
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 20.0,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text('Options'),
                        ),
                        actions: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (Widget child,
                                    Animation<double> animation) =>
                                ScaleTransition(child: child, scale: animation),
                            child: _bannerFilterActions[_filterAction.value],
                          ),
                        ],
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: _filterAction,
                        builder: (context, value, child) {
                          visibleCards = value == 0
                              ? _cards
                              : value == 1
                                  ? _marketplaceCards
                                  : _foodAndDrugCards;
                          return SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Container(
                                    color: Colors.white,
                                    height: 100 + index % 4 * 20.0,
                                    child: visibleCards.elementAt(index));
                              },
                              childCount: visibleCards.length,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }),
          );
        });
  }
}
