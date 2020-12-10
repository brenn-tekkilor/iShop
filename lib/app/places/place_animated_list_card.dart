import 'package:flutter/material.dart';
import 'package:ishop/app/places/places_provider.dart';
import 'package:ishop/com/interfaces/fire_animated_list_card.dart';
import 'package:ishop/com/interfaces/place_details_doc.dart';
import 'package:ishop/data/model/place_details.dart';
import 'package:provider/provider.dart';

/// PlaceAnimatedListCard
class PlaceAnimatedListCard<T extends PlaceDetailsDoc> extends StatelessWidget
    implements FireAnimatedListCard {
  /// PlaceAnimatedListCard constructor
  const PlaceAnimatedListCard(
      {Key? key,
      @required required int index,
      @required required Animation<double> animation,
      @required required T item,
      @required required VoidCallback onTap,
      bool isSelected = false})
      : _index = index,
        _item = item,
        _isSelected = isSelected,
        _animation = animation,
        _onTap = onTap,
        super(key: key);
  final int _index;
  final T _item;
  final Animation<double> _animation;
  final VoidCallback _onTap;
  final bool _isSelected;
  @override
  int get index => _index;
  @override
  T get item => _item;
  @override
  bool get isSelected => _isSelected;
  @override
  Animation<double> get animation => _animation;
  @override
  VoidCallback get onTap => _onTap;
  @override
  String get logoPath => item.logo2;
  @override
  String get subtitle => item.subtitle;
  @override
  String get title => item.title;
  @override
  Color get color => item.color;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: 2,
          right: 2,
          top: 2,
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.5, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: const Interval(
                0,
                1,
                curve: Curves.easeIn,
              ),
            ),
          ),
          child: GestureDetector(
            onTap: onTap,
            child: SizedBox(
              height: 60,
              child: Card(
                margin: const EdgeInsets.all(3),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                shadowColor: Colors.grey.withOpacity(0.5),
                color: context.select<PlacesProvider, PlaceDetails>(
                            (p) => p.selectedPlace) ==
                        item
                    ? color
                    : color.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100,
                      margin: const EdgeInsets.only(left: 5),
                      child: ClipRect(
                        child: Image.asset(logoPath, fit: BoxFit.cover),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(subtitle,
                            style:
                                Theme.of(context).primaryTextTheme.subtitle2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
