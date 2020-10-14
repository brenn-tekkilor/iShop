import 'package:flutter/material.dart';
import 'package:ishop/pages/poi/poi_state.dart';
import 'package:ishop/utils/util.dart';

class POISwitch extends StatelessWidget {
  const POISwitch({Key key, @required this.banner})
      : otherBanner = banner == BannerType.foodAndDrug
            ? BannerType.marketplace
            : BannerType.foodAndDrug,
        super(key: key);
  final BannerType banner;
  final BannerType otherBanner;

  @override
  Widget build(BuildContext context) {
    final data = LocationDataProvider.of(context).locationData;
    void onChanged(bool value) =>
        data.streamingBanner = !!value ? BannerType.all : otherBanner;
    bool getValue(BannerType filter) => filter != null
        ? (filter == BannerType.all || filter == banner)
            ? true
            : false
        : true;
    return ValueListenableBuilder<BannerType>(
      builder: (BuildContext context, BannerType filter, _) => Switch(
        value: getValue(filter),
        onChanged: onChanged,
      ),
      valueListenable: data.streamingBannerListenable,
    );
  }
}
