import 'package:flutter/material.dart';
import 'package:ishop/model/places.dart';
import 'package:ishop/pages/poi/poi_page.dart';
import 'package:ishop/pages/poi/poi_state.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppData _data;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final appBarText = Theme.of(context).textTheme.bodyText1;
    return FutureBuilder<AppData>(
        future: AppData().initialize(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
                child: Text('Error with future model!',
                    textDirection: TextDirection.rtl));
          }
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          _data = snapshot.data;
          return Scaffold(
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
                    builder: (BuildContext context,
                        RetailLocation preferredStore, Widget child) {
                      if (preferredStore == null) {
                        return TextButton(
                          child: Text('CHOOSE PICKUP!'),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              fullscreenDialog: true,
                              builder: (BuildContext context) =>
                                  POIPage(data: _data),
                            ),
                          ),
                        );
                      }
                      return TextButton(
                        child: Text(preferredStore.name.toUpperCase()),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (BuildContext context) =>
                                POIPage(data: _data),
                          ),
                        ),
                      );
                    },
                    valueListenable: _data.preferredStoreNotifier,
                  )),
                ),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Please choose a store.',
                    style: Theme.of(context).typography.black.headline2,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
