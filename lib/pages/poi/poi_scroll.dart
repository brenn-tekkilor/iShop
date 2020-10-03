import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ishop/model/poi_model.dart';
import 'package:ishop/pages/poi/poi_filter.dart';
import 'package:provider/provider.dart';

class POIScroll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<POIProvider>(builder: (context, model, _) {
      final model = context.watch<POIProvider>();
      final markers = model.model.markers;
      final mapController = model.model.mapController.future;
      return DraggableScrollableSheet(
        initialChildSize: 0.1,
        minChildSize: 0.1,
        maxChildSize: 0.7,
        expand: true,
        builder: (context, scrollController) {
          return CustomScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 20.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Options'),
                ),
                actions: <Widget>[
                  POIFilter(),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  if (index < markers.length) {
                    final marker = markers.isNotEmpty
                        ? markers.elementAt(index)
                        : Marker(
                            markerId: MarkerId(index.toString()),
                            position: model.model.deviceLocation,
                            infoWindow: InfoWindow(
                              title: 'Null marker id: $index',
                              snippet: 'Null data at markers[$index]',
                            ),
                          );
                    return Container(
                      height: 100 + index % 4 * 20.0,
                      child: ListTile(
                        key: ValueKey(marker.markerId.value),
                        tileColor: Colors.cyan,
                        title: Text(
                          marker.infoWindow.title,
                          textDirection: TextDirection.rtl,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        subtitle: Text(marker.infoWindow.snippet),
                        onTap: () async {
                          final controller = await mapController;
                          await controller.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: marker.position,
                                zoom: 16,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return null;
                }),
              ),
            ],
          );
        },
      );
    });
  }
}
