import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/model/places.dart';
import 'package:ishop/pages/poi/poi_state.dart';
import 'package:ishop/utils/map_utils.dart';
import 'package:ishop/utils/styles.dart';
import 'package:ishop/utils/util.dart';

class ExpandableCard extends StatefulWidget {
  const ExpandableCard._create(ValueKey key, {@required this.info})
      : super(key: key);
  final CardInfo info;

  @override
  State<ExpandableCard> createState() => _ExpandableCardState(info: info);

  static ExpandableCard fromDocument(DocumentSnapshot doc) {
    assert(doc != null);
    return ExpandableCard._create(ValueKey(doc.id),
        info: CardInfo.fromDocument(doc));
  }
}

class _ExpandableCardState extends State<ExpandableCard> {
  _ExpandableCardState({@required this.info});

  final CardInfo info;
  ExpandableController controller;

  @override
  Widget build(BuildContext context) {
    final data = AppState.of(context).state;
    final width = MediaQuery.of(context).size.width;
    final titleStyle = Theme.of(context).accentTextTheme.headline4;

    Widget buildCollapsed() => GestureDetector(
        child: Container(
          color: info.color,
          height: 50,
          width: width,
          child: Center(
            child: Text(info.title, style: titleStyle),
          ),
        ),
        onTap: () {
          if (!controller.expanded) {
            data.animateMapToLatLng(info.latLng);
          }
          controller.toggle();
        },
        onTapCancel: () {
          if (controller.expanded) {
            controller.toggle();
          }
        });
    Widget buildExpanded() => Container(
          width: width,
          height: 100.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildCollapsed(),
              Divider(
                height: 1.0,
                thickness: 1.0,
              ),
              Container(
                color: info.color,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        child: Text(
                          'Cancel',
                          style: Theme.of(context).typography.black.headline5,
                        ),
                        onPressed: () => controller.expanded = false,
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        child: Text(
                          'Accept',
                          style: Theme.of(context).typography.black.headline5,
                        ),
                        onPressed: () {
                          data.preferredStore =
                              RetailLocation.fromCardInfo(info);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
    return Container(
      padding: EdgeInsets.all(2.0),
      width: width,
      child: Card(
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        child: ExpandableNotifier(
          child: ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: Builder(builder: (context) {
              controller = ExpandableController.of(context);
              return ExpandablePanel(
                theme: AppStyles.expandableTheme,
                collapsed: buildCollapsed(),
                expanded: buildExpanded(),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class CardInfo {
  const CardInfo._create(
      {@required this.id,
      @required this.latLng,
      @required this.title,
      @required this.banner});
  factory CardInfo.fromDocument(DocumentSnapshot doc) {
    var banner = BannerType.foodAndDrug;
    LatLng latLng;
    var title = 'Untitled';
    var id = '0';
    if (doc != null) {
      id = doc.id;
      final data = doc.data();
      if (data != null) {
        String name = data['name'];
        title = (name != null && name.isNotEmpty) ? name : title;
        String bannerString = data['meta']['banner'];
        banner = (bannerString != null &&
                bannerString.isNotEmpty &&
                bannerString == 'marketplace')
            ? BannerType.marketplace
            : banner;

        GeoPoint point = data['point']['geopoint'];

        latLng = point != null ? latLng = geoPointToLatLng(point) : latLng;
      }
    }
    return CardInfo._create(
        id: id, latLng: latLng, title: title, banner: banner);
  }

  final String id;
  final LatLng latLng;
  final String title;
  final BannerType banner;

  Color get color => banner == BannerType.marketplace
      ? AppStyles.primaryColorSwatch.shade300.withOpacity(0.7)
      : AppStyles.secondaryColorSwatch.shade300.withOpacity(0.7);
}
