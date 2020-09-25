import 'package:flutter/material.dart';
import 'package:frino_icons/frino_icons.dart';

class BannerFilterActionNotifier extends ChangeNotifier {
  BannerFilterActionNotifier(this._value);
  int _value;

  int get value => _value;

  set value(int value) {
    _value = value;
    notifyListeners();
  }
}

class BannerFilterActions extends StatefulWidget {
  @override
  _BannerFilterActionsState createState() => _BannerFilterActionsState();
}

class _BannerFilterActionsState extends State<BannerFilterActions> {
  _BannerFilterActionsState() {
    _bannerFilterActions.addAll([
      IconButton(
          key: ValueKey(0),
          icon: Icon(FrinoIcons.f_infinity),
          onPressed: () {
            setState(() {
              actionNotifier = ValueNotifier(1);
            });
          }),
      IconButton(
          key: ValueKey(1),
          icon: Icon(FrinoIcons.f_shop),
          onPressed: () {
            setState(() {
              actionNotifier = ValueNotifier(2);
            });
          }),
      IconButton(
          key: ValueKey(2),
          icon: Icon(FrinoIcons.f_basket),
          onPressed: () {
            setState(() {
              actionNotifier = ValueNotifier(0);
            });
          }),
    ]);
    actionNotifier = ValueNotifier(0);
  }
  final _bannerFilterActions = <IconButton>[];
  ValueNotifier<int> actionNotifier;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation<double> animation) =>
          ScaleTransition(child: child, scale: animation),
      child: _bannerFilterActions[actionNotifier.value],
    );
  }
}
