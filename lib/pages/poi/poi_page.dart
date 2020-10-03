import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ishop/model/poi_model.dart';
import 'package:ishop/pages/poi/poi_filter.dart';
import 'package:ishop/pages/poi/poi_map.dart';
import 'package:ishop/pages/poi/poi_scroll.dart';
import 'package:ishop/pages/poi/poi_slider.dart';
import 'package:provider/provider.dart';

class POIPage extends StatelessWidget {
  //#region overrides
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return FutureBuilder<POIModelState>(
        future: POIModelState.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
                child: Text('Error with future model!',
                    textDirection: TextDirection.rtl));
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final provider = POIProvider(model: snapshot.data);
          return ChangeNotifierProvider.value(
            value: provider,
            builder: (context, _) => Scaffold(
              body: Container(
                width: width,
                height: height,
                child: Stack(
                  children: <Widget>[
                    POIMap(),
                    Positioned(
                      bottom: 150,
                      left: 0,
                      child: SizedBox(
                        width: width,
                        height: 100.0,
                        child: POISlider(),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 10,
                      child: POIFilter(),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: POIScroll(),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
