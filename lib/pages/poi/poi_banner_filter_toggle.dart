import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:ishop/utils/util.dart' show BannerType;

class BannerFilterNotification extends Notification {
  BannerFilterNotification(this.banner);
  final BannerType banner;
}

class BannerFilterButton extends IconButton {
  BannerFilterButton(this.banner, Icon icon, Function onPressed)
      : assert(banner != null),
        super(key: ValueKey(banner.index), icon: icon, onPressed: onPressed);

  final BannerType banner;
}

class POIBannerFilterToggle extends StatefulWidget {
  @override
  _POIBannerFilterToggleState createState() => _POIBannerFilterToggleState();
}

class _POIBannerFilterToggleState extends State<POIBannerFilterToggle> {
  final _filters = <BannerFilterButton>[];
  BannerType nextFilter;

  @override
  void initState() {
    super.initState();
    _filters.addAll([
      BannerFilterButton(BannerType.all, Icon(FrinoIcons.f_infinity), () {
        setState(() {
          nextFilter = BannerType.foodAndDrug;
        });
        BannerFilterNotification(BannerType.all)..dispatch(context);
      }),
      BannerFilterButton(BannerType.foodAndDrug, Icon(FrinoIcons.f_basket), () {
        setState(() {
          nextFilter = BannerType.marketplace;
        });
        BannerFilterNotification(BannerType.foodAndDrug)..dispatch(context);
      }),
      BannerFilterButton(BannerType.marketplace, Icon(FrinoIcons.f_shop), () {
        setState(() {
          nextFilter = BannerType.all;
        });
        BannerFilterNotification(BannerType.marketplace)..dispatch(context);
      }),
    ]);
    nextFilter = BannerType.foodAndDrug;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          ScaleTransition(child: child, scale: animation),
      child: _filters.firstWhere((f) => f.banner.index == nextFilter.index),
    );
  }
}
