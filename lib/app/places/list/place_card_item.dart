// Displays its integer item as 'Item N' on a Card whose color is based on
// the item's value.
//
// The card turns gray when [selected] is true. This widget's height
// is based on the [animation] parameter. It varies as the animation value
// transitions from 0.0 to 1.0.
import 'package:flutter/material.dart';
import 'package:ishop/data/model/place_info.dart';

class PlaceCardItem extends StatelessWidget {
  const PlaceCardItem({
    Key? key,
    @required required this.animation,
    @required required this.item,
    this.info = _defaultPlaceInfo,
    required this.onTap,
    this.selected = false,
  }) : super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final PlaceInfo info;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 2.0,
        right: 2.0,
        top: 2.0,
        bottom: 0.0,
      ),
      child: Transform(
        transform: Matrix4.identity()..translate(animation.value),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.all(10),
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.elliptical(5, 5),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 20,
                      offset: Offset.zero,
                      color: Colors.grey.withOpacity(0.5))
                ]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 50,
                  margin: EdgeInsets.only(left: 5),
                  child: ClipRect(
                      child: Image.asset(info.logoPath, fit: BoxFit.cover)),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(info.name,
                        style: Theme.of(context)?.primaryTextTheme.subtitle2),
                  ),
                ),
                /*
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Image.asset(info.pinPath, width: 50, height: 50),
                )
                 */
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const _defaultPlaceInfo = PlaceInfo();
}
