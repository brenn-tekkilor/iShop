import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:ishop/pages/poi/poi_state.dart';
import 'package:ishop/utils/util.dart';

class POIFilterProperties {
  const POIFilterProperties({@required this.icon, @required this.tooltip});
  final Icon icon;
  final String tooltip;
}

class POIFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _POIFilterState();
}

class _POIFilterState extends State<POIFilter> {
  static final _filters = <BannerType, POIFilterProperties>{
    BannerType.all: POIFilterProperties(
      icon: Icon(FrinoIcons.f_infinity),
      tooltip: 'FILTER: ALL',
    ),
    BannerType.foodAndDrug: POIFilterProperties(
      icon: Icon(FrinoIcons.f_basket),
      tooltip: 'FILTER: FOOD & DRUG',
    ),
    BannerType.marketplace: POIFilterProperties(
      icon: Icon(FrinoIcons.f_shop),
      tooltip: 'FILTER: MARKETPLACE',
    ),
  };

  POIStateData data;

  IconButton _nextFilterButton;

  BannerType _peekNextFilter(BannerType current) =>
      current.index != BannerType.values.last.index
          ? BannerType.values[current.index + 1]
          : BannerType.values[0];

  Widget _buildFilterButton(BannerType filter) => IconButton(
        icon: _filters[filter].icon,
        tooltip: _filters[filter].tooltip,
        color: Colors.blueAccent,
        onPressed: () {
          data.filter = _peekNextFilter(filter);
          setState(() {
            _nextFilterButton = _buildFilterButton(_peekNextFilter(filter));
          });
        },
      );

  @override
  Widget build(BuildContext context) {
    data = POIState.of(context).state;
    _nextFilterButton = _buildFilterButton(_peekNextFilter(data.filter));

    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(child: child, scale: animation),
        child: _nextFilterButton);
  }
}
