import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';
import 'package:ishop/pages/poi/poi_state.dart';
import 'package:ishop/utils/util.dart';

class POITogglesBar extends StatefulWidget {
  @override
  _POITogglesBarState createState() => _POITogglesBarState();
}

class _POITogglesBarState extends State<POITogglesBar> {
  POIState _data;
  List<bool> get _isSelected {
    switch (_data.filter) {
      case BannerType.all:
        {
          return <bool>[true, true];
        }
        break;
      case BannerType.foodAndDrug:
        {
          return <bool>[true, false];
        }
        break;
      case BannerType.marketplace:
        {
          return <bool>[false, true];
        }
        break;
      default:
        {
          return <bool>[true, true];
        }
        break;
    }
  }

  set _isSelected(List<bool> value) {
    if (_data != null) {
      _data.filter = (value[0] && value[1])
          ? BannerType.all
          : (!value[0] && value[1])
              ? BannerType.marketplace
              : (value[0] && !value[1])
                  ? BannerType.foodAndDrug
                  : BannerType.all;
    }
  }

  void _onPressed(int index) {
    var toggles = _isSelected;
    var count = 0;
    toggles.forEach((bool val) {
      if (val) count++;
    });

    if (toggles[index] && count < 2) return;

    toggles[index] = !toggles[index];
    setState(() {
      _isSelected = toggles;
    });
  }

  @override
  Widget build(BuildContext context) {
    _data ??= POIStateContainer.of(context).state;
    return Container(
      alignment: Alignment.center,
      child: ToggleButtons(
        children: <Widget>[
          Icon(
            FrinoIcons.f_basket,
            size: 40,
          ),
          Icon(
            FrinoIcons.f_shop,
            size: 40,
          ),
        ],
        onPressed: (int index) => _onPressed(index),
        isSelected: _isSelected,
      ),
    );
  }
}
