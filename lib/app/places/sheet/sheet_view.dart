import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ishop/data/service/places_api.dart';

class SheetView extends StatefulWidget {
  @override
  _SheetViewState createState() => _SheetViewState();
}

class _SheetViewState extends State<SheetView> {
  final cards = <Card>{};
  StreamSubscription<Set<Card>>? cardSubscription;
  void _updateCards(Set<Card> value) {
    cards.clear();
    cards.addAll(value);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cardSubscription = PlacesAPI.instance().cardStream.listen(_updateCards);
  }

  @override
  void dispose() {
    if (cardSubscription != null) {
      cardSubscription?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
