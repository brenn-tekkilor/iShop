import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:provider/provider.dart';

///PlaceRange
class PlaceRange extends StatelessWidget {
  ///PlaceRange constructor
  const PlaceRange({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<PlacesProvider>(
        builder: (context, provider, child) => SizedBox(
          width: 50,
          height: 300,
          child: Material(
            type: MaterialType.transparency,
            child: RotatedBox(
              quarterTurns: 3,
              child: Slider(
                  max: 100,
                  divisions: 10,
                  value: provider.sliderValue,
                  label: '${provider.miles} mi.',
                  onChanged: (value) {
                    provider.sliderValue = value;
                  }),
            ),
          ),
        ),
      );
}
