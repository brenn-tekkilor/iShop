import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/data/model/place_info.dart';
import 'package:ishop/styles.dart';
import 'package:provider/provider.dart';

/// PlaceCardItem
class PlaceCardItem extends StatefulWidget {
  /// PlaceCardItem default const constructor
  const PlaceCardItem({
    Key? key,
    @required required this.index,
    @required required this.info,
  }) : super(key: key);

  /// the index if in a list or nan
  final int index;

  /// the place info
  final PlaceInfo info;
  @override
  _PlaceCardItemState createState() => _PlaceCardItemState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<int>.has('index', index))
      ..add(ObjectFlagProperty<PlaceInfo>.has('info', info));
  }
}

class _PlaceCardItemState extends State<PlaceCardItem> {
  @override
  Widget build(BuildContext context) {
    var selectedPlace =
        context.select<PlacesProvider, PlaceInfo?>((p) => p.selectedPlace);
    final isSelected = selectedPlace == widget.info;
    final bgColor = isSelected ? Colors.blueGrey : Colors.white;
    return Padding(
      padding: const EdgeInsets.only(
        left: 2,
        right: 2,
        top: 2,
      ),
      child: GestureDetector(
        onTap: () {
          selectedPlace = isSelected ? null : widget.info;
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 70,
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: const BorderRadius.all(
                Radius.elliptical(5, 5),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(blurRadius: 20, color: Colors.grey.withOpacity(0.5))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 50,
                margin: const EdgeInsets.only(left: 5),
                child: ClipRect(
                    child:
                        Image.asset(widget.info.logoPath, fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(widget.info.name,
                      style: AppStyles.primaryTextTheme.subtitle2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
