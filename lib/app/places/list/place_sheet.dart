import 'package:flutter/material.dart';
import 'package:ishop/app/places/list/place_animated_list.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:provider/provider.dart';

/// PlaceSheet
class PlaceSheet extends StatelessWidget {
  /// PlaceSheet default const constructor
  const PlaceSheet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
      minChildSize: 0.01,
      initialChildSize: 0.1,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        Provider.of<PlacesProvider>(context, listen: false).scrollController =
            scrollController;
        return CustomScrollView(
            controller: scrollController,
            shrinkWrap: true,
            slivers: const [
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
                toolbarHeight: 28,
                collapsedHeight: 30,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                titleSpacing: 0,
                backgroundColor: Colors.blueGrey,
                shadowColor: Colors.black38,
                expandedHeight: 35,
                title: Padding(
                  padding: EdgeInsets.only(bottom: 18),
                  child: Text(
                    'VIEW LIST',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Metrophobic',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                centerTitle: true,
              ),
              PlaceAnimatedList(),
            ]);
      });
}
