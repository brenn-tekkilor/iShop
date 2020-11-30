import 'package:flutter/material.dart';
import 'package:ishop/app/places/list/place_animated_list.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/styles.dart';
import 'package:provider/provider.dart';

/// PlaceSheet
class PlaceSheet extends StatelessWidget {
  /// PlaceSheet default const constructor
  const PlaceSheet({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
      minChildSize: 0.05,
      initialChildSize: 0.1,
      maxChildSize: 0.4,
      builder: (context, scrollController) {
        Provider.of<PlacesProvider>(context, listen: false).scrollController =
            scrollController;
        return CustomScrollView(
            controller: scrollController,
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                toolbarHeight: 30,
                collapsedHeight: 40,
                title: Text('View List',
                    style: AppStyles.primaryTypography.white.headline6),
                centerTitle: true,
              ),
              const PlaceAnimatedList(),
            ]);
      });
}
