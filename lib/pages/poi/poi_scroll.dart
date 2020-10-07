import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/pages/poi/poi_state.dart';
import 'package:ishop/utils/colors.dart';
import 'package:ishop/utils/map_utils.dart';
import 'package:ishop/utils/util.dart';

class POIScroll extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _POIScrollState();
}

class _POIScrollState extends State<POIScroll> {
  //#region properties

  final _cards = <CardItem>{};
  POIStateData _data;
  Completer _controller;

  //#endregion

  //#region methods

  //#region Stream and Scrollable List

  StreamSubscription<List<DocumentSnapshot>> _subscription;

  void _addCard(CardItem value) {
    assert(value != null);
    if (!_cards.contains(value)) {
      _cards.removeWhere((e) => e.key == value.key);
      _cards.add(value);
    }
  }

  CardItem _docToCard(DocumentSnapshot doc) {
    final data = doc.data();
    final banner = data['meta']['banner'];
    final point = data['point']['geopoint'];
    return CardItem(
      key: ValueKey(doc.id),
      data: CardItemData(
        title: data['name'],
        subtitle: banner,
      ),
      onTap: () async {
        await _controller.future
            .then((value) => value.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: geoPointToLatLng(point),
                    zoom: 16,
                  ),
                )))
            .catchError((e) => print(e));
      },
    );
  }

  void _updateCards(List<DocumentSnapshot> docs) {
    _cards.clear();
    docs.forEach((e) => _addCard(_docToCard(e)));
    setState(() {});
  }

  //#endregion

  //#region slider

  Container get _poiSlider => Container(
        padding: EdgeInsets.fromLTRB(2, 0, 0, 2),
        height: 60,
        alignment: Alignment.center,
        child: Slider(
          min: 2.0,
          max: 100,
          value: _data.radius,
          onChanged: (value) => _data.radius = value,
          activeColor: Colors.cyan.withOpacity(0.8),
          inactiveColor: Colors.cyan.withOpacity(0.2),
        ),
      );

  //#endregion

  //#region toggle buttons

  //#region _isToggleSelected(BannerType) (ie: ToggleButtons.isSelected getter)

  List<bool> _isToggleSelected(BannerType toggle) =>
      (_data.filter == BannerType.all ||
              (toggle == BannerType.foodAndDrug &&
                  _data.filter == BannerType.foodAndDrug) ||
              (toggle == BannerType.marketplace &&
                  _data.filter == BannerType.marketplace))
          ? [true]
          : [false];

  //#endregion

  ////#region _onToggle(BannerType) (ie: ToggleButtons.onPressed callback)
  ///////////////////////////////////////////////////////////
  /// Controls the firebase query filter sent by
  /// the stream controller such that the stream returns
  /// either all items, only food and drug items, or
  /// only marketplace items.  On Pressed,
  /// this function uses the current filter state
  /// when deciding to set a new filter value or do nothing.
  /// If the toggle button pressed is currently in a selected state
  /// while the other is not, than this function does nothing
  /// as setting both toggles' states to unselected is analogous
  /// to setting a query that returns no items.  However, if
  /// current filter is set to show all items, then a new filter
  /// value, equal to the banner type controlled by the calling
  /// widget.  Otherwise, the calling toggle button is in an
  /// unselected state and only the other toggle button's toggleable
  /// value is being show, and therefore, a new filter value
  /// of BannerType.all will be set.

  void _onToggle(BannerType filter) {
    if (_data.filter != filter) {
      _data.filter = _data.filter == BannerType.all
          ? filter == BannerType.foodAndDrug
              ? _data.filter = BannerType.marketplace
              : _data.filter = BannerType.foodAndDrug
          : _data.filter = BannerType.all;
    }
  }

  //#endregion

  //#region _poiToggles (ie: returns two toggle buttons)

  List<ToggleButtons> get _foodToggles => <ToggleButtons>[
      //#region show only foodAndDrug toggle button
            ToggleButtons(
              isSelected: _isToggleSelected(BannerType.foodAndDrug),
              //#region onPressed callback function
              onPressed: (index) => _onToggle(BannerType.foodAndDrug),
              children: <Widget>[
                Icon(
                  FrinoIcons.f_basket,
                  size: 32,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
            //#endregion
            //#endregion
      //#region show only marketplaces toggle button
            ToggleButtons(
              isSelected: _isToggleSelected(BannerType.marketplace),
              onPressed: (index) => _onToggle(BannerType.marketplace),
              children: <Widget>[
                Icon(
                  FrinoIcons.f_shop,
                  size: 32,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
                //#endregion
          ];

  //#endregion

  //#endregion

  @override
  Widget build(BuildContext context) {
    _data ??= POIState.of(context).state;
    _controller ??= _data.mapController;
    _subscription ??= _data.poiStream.listen(_updateCards);

    return DraggableScrollableSheet(
        initialChildSize: 0.1,
        minChildSize: 0.1,
        maxChildSize: 0.7,
        expand: true,
        builder: (context, scrollController) {
          _data.poiScrollController = scrollController;
          return CustomScrollView(
            controller: _data.poiScrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.blueGrey.withOpacity(0.2),
                toolbarHeight: 40,
                collapsedHeight: 45,
                expandedHeight: 100.0,
                floating: true,
                snap: true,
                actions: <Widget>[
                      Flexible(
                        flex: 3,
                        fit: FlexFit.loose,
                        child: _poiSlider,
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Spacer(),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child:
                      )
                    ],
                  ),
                ],
              ),
              //bottom:
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _cards.elementAt(index),
                  childCount: _cards.length,
                ),
              ),
            ],
          );
        });
  }
}

//#region Card Item class

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
          height: 100,
          child: Card(
            color: data.subtitle == 'marketplace'
                ? AppColors.primaryLightColor.withOpacity(0.6)
                : AppColors.secondaryLightColor.withOpacity(0.6),
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

//#endregion
