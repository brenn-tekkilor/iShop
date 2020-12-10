import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ishop/app/app_provider.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/data/model/place_details.dart';
import 'package:provider/provider.dart';

/// MapPin
class IShopMapMarkerInfoWindow extends StatefulWidget {
  /// MapPin constructor
  const IShopMapMarkerInfoWindow({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IShopMapMarkerInfoWindowState();
}

class _IShopMapMarkerInfoWindowState extends State<IShopMapMarkerInfoWindow> {
  @override
  Widget build(BuildContext context) => AnimatedPositioned(
        bottom: context.select<PlacesProvider, PlaceDetails?>(
                    (p) => p.selectedPlace) !=
                null
            ? 475
            : -250,
        right: 0,
        left: 0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 10,
            child: Card(
              color: Colors.transparent,
              margin: const EdgeInsets.all(5),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                  side: BorderSide(
                    width: 0.8,
                    color: Colors.grey,
                  )),
              shadowColor: Colors.black.withOpacity(0.8),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    transform: const GradientRotation(45),
                    colors: <Color>[
                      Colors.grey.withOpacity(0.7),
                      Colors.white70.withOpacity(0.7),
                      Colors.blueGrey.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: 150,
                        margin: const EdgeInsets.fromLTRB(10, 5, 10, 2),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.elliptical(20, 20),
                            right: Radius.elliptical(20, 20),
                          ),
                        ),
                        child: ClipRect(
                            child: Image.asset(context
                                    .watch<PlacesProvider>()
                                    .selectedPlace
                                    ?.logo1 ??
                                'assets/logos/kroger_logo.png'))),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 5, 15, 3),
                      child: Text(
                        context.watch<PlacesProvider>().selectedPlace?.name ??
                            '',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .headline5
                            ?.copyWith(
                              letterSpacing: 3.5,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 1),
                      child: OutlinedButton(
                        onPressed: () {
                          context.read<AppProvider>().preferredPlace =
                              context.read<PlacesProvider>().selectedPlace;
                          Navigator.of(context)?.pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'SHOP THIS STORE',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .button
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                  fontSize: 16,
                                  wordSpacing: 6,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
