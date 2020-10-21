import 'package:flutter/material.dart';
import 'package:ishop/core/models/place.dart';
import 'package:ishop/core/util/scribe.dart';
import 'package:ishop/views/base/base_view.dart';
import 'package:ishop/views/home/home_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appBarText = Theme.of(context).textTheme.bodyText1;
    return BaseView<HomeModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.0,
          title: Text('iShop'),
          actions: [
            Container(
              height: 40.0,
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              alignment: Alignment.centerRight,
              child: Expanded(
                child: ValueListenableBuilder(
                  builder: (BuildContext context, Place place, Widget child) =>
                      (place.id.isEmpty)
                          ? TextButton(
                              child: Text('CHOOSE PICKUP!', style: appBarText),
                              onPressed: () =>
                                  Navigator.of(context).pushNamed('places'),
                            )
                          : TextButton(
                              child: Text(
                                  Scribe.condense(
                                      value: place.name.toUpperCase(),
                                      max: 30,
                                      trailing: '...'),
                                  style: appBarText),
                              onPressed: () =>
                                  Navigator.of(context).pushNamed('places'),
                            ),
                  valueListenable: model.placeNotifier,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Please choose a place.',
                style: Theme.of(context).typography.black.headline2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
