import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ishop/app/home/home_provider.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/app_styles.dart';
import 'package:ishop/data/model/place_details.dart';
import 'package:provider/provider.dart';

/// MapPin
class MapPin extends StatefulWidget {
  /// MapPin constructor
  const MapPin({Key? key, this.pinPosition = -100}) : super(key: key);

  /// pinPosition
  final double pinPosition;

  @override
  State<StatefulWidget> createState() => _MapPinState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('pinPosition', pinPosition));
  }
}

class _MapPinState extends State<MapPin> {
  @override
  Widget build(BuildContext context) {
    final selectedPlace =
        context.select<PlacesProvider, PlaceDetails?>((p) => p.selectedPlace);
    return AnimatedPositioned(
      bottom: selectedPlace == null ? -150 : 300,
      right: 0,
      left: 0,
      duration: const Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.all(20),
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              boxShadow: <BoxShadow>[
                BoxShadow(blurRadius: 20, color: Colors.grey.withOpacity(0.5))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 50,
                margin: const EdgeInsets.only(left: 10),
                child: ClipRect(
                    child: Image.asset(
                        selectedPlace?.logo1 ?? 'assets/images/kroger_logo.png',
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(selectedPlace?.title ?? '',
                          style: TextStyle(
                              color: selectedPlace?.color ?? Colors.blue)),
                      Text(selectedPlace?.name ?? '',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: IconButton(
                  icon: const FaIcon(FontAwesomeIcons.check,
                      color: primaryColor, size: 50),
                  onPressed: () => {
                    Provider.of<HomeProvider>(context).preferredPlace =
                        selectedPlace
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
