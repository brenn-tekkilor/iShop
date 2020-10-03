import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:ishop/model/poi_model.dart';
import 'package:ishop/utils/util.dart';
import 'package:provider/provider.dart';

class POIFilter extends StatelessWidget {
  final _filters = <BannerType, Icon>{
    BannerType.all: Icon(FrinoIcons.f_infinity),
    BannerType.foodAndDrug: Icon(FrinoIcons.f_basket),
    BannerType.marketplace: Icon(FrinoIcons.f_shop)
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<POIProvider>(builder: (context, model, _) {
      var filter =
          context.select<POIProvider, BannerType>((p) => p.model.filter);
      return AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (Widget child, Animation<double> animation) =>
              ScaleTransition(child: child, scale: animation),
          child: IconButton(
            icon: _filters[model.model.filter],
            color: Colors.blueAccent,
            onPressed: () {
              final newFilter = filter.index != BannerType.values.last.index
                  ? BannerType.values[filter.index + 1]
                  : BannerType.values[0];
              model.model.filter = newFilter;
            },
          ));
    });
  }
}
