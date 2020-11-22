import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/data/model/place_info.dart';
import 'package:ishop/data/service/places_api.dart';
import 'package:ishop/styles.dart';
import 'package:provider/provider.dart';

class PlacesSheet extends StatefulWidget {
  @override
  _PlacesSheetState createState() => _PlacesSheetState();
}

class _PlacesSheetState extends State<PlacesSheet> {
  final api = PlacesAPI.instance();
  final placesSet = <PlaceInfo>{};
  StreamSubscription<Set<PlaceInfo>>? placesSubscription;

  void _updatePlaces(Set<PlaceInfo> value) {
    placesSet.clear();
    placesSet.addAll(value);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    placesSubscription = api.placeInfoStream.listen(_updatePlaces);
  }

  @override
  void dispose() {
    if (placesSubscription != null) {
      placesSubscription?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      builder: (context, value, child) {
        final opacity = value ? 1.0 : 0.0;
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      valueListenable: Provider.of<PlacesProvider>(context).sheetNotifier,
      child: DraggableScrollableSheet(
        initialChildSize: 0.04,
        minChildSize: 0.04,
        maxChildSize: 0.4,
        expand: true,
        builder: (context, scrollController) {
          api.sheetScroller = scrollController;
          return CustomScrollView(
            controller: api.sheetScroller,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            slivers: <Widget>[
              SliverAppBar(
                title: Container(
                  height: 20.0,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 5.0,
                        color: Colors.lightBlue.shade50,
                      ),
                    ),
                  ),
                ),
                automaticallyImplyLeading: false,
                backgroundColor: Colors.grey,
                toolbarHeight: 20.0,
                collapsedHeight: 20.01,
                expandedHeight: 20.0,
                shadowColor: AppStyles.primaryTheme.shadowColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(20, 10),
                    topRight: Radius.elliptical(20, 10),
                  ),
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 120.0,
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final p = placesSet.elementAt(index);
                    return Card(
                      child: ListTile(
                        title: Text(p.name,
                            style: AppStyles.secondaryTextTheme.headline5),
                        subtitle: Text(p.banner,
                            style: AppStyles.secondaryTextTheme.subtitle1),
                        onTap: () {
                          PlacesAPI.instance().animateMapTo(p.latLng);
                        },
                      ),
                    );
                  },
                  childCount: placesSet.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
