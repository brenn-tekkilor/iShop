import 'dart:ui';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ishop/utils/colors.dart';
import 'package:ishop/utils/text_styles.dart';
import 'package:ishop/utils/ui_helpers.dart';
import 'package:ishop/widgets/basic_tile.dart';

import 'file:///C:/Users/brenn/source/repos/brenn/ishop/lib/model/poi_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //#region final page names

  final itemNames = [
    'Home',
    'Map',
    'Admin',
  ];

  POIModel service;

  //#endregion

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: invertInvertColorsStrong(context),
          body: Container(
            width: _width,
            height: _height,
            child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40.0,
                      top: 60.0,
                      bottom: 10.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'iShop',
                          style: isThemeCurrentlyDark(context)
                              ? TitleStylesDefault.white
                              : TitleStylesDefault.black,
                        ),
                      ],
                    ),
                  ),
                  Flex(
                    mainAxisSize: MainAxisSize.min,
                    direction: Axis.vertical,
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.loose,
                        child: GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 1,
                          childAspectRatio: 2.5,
                          children: List.generate(
                            itemNames.length,
                            (index) {
                              return Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Hero(
                                    tag: 'tile$index',
                                    //using a different hero widget tag for
                                    // each page mapped to the page's index value
                                    child: BasicTile(),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(15.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Hero(
                                              tag: 'title$index',
                                              child: Material(
                                                color: Colors.transparent,
                                                child: Text(
                                                  '${itemNames[index]}',
                                                  style: isThemeCurrentlyDark(
                                                          context)
                                                      ? LabelStyles.white
                                                      : LabelStyles.black,
                                                  softWrap: true,
                                                  overflow: TextOverflow.fade,
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        splashColor: MyColors.accent,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        onTap: () {
                                          if (index == 1) {
                                            //return POIPage();
                                            Navigator.pushNamed(
                                                context, '/poi');
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'fab',
            child: isThemeCurrentlyDark(context)
                ? Icon(
                    EvaIcons.sun,
                    size: 30.0,
                  ) //show sun icon when in dark mode
                : Icon(
                    EvaIcons.moon,
                    size: 26.0,
                  ),
            //show moon icon when in light mode
            tooltip: isThemeCurrentlyDark(context)
                ? 'Switch to light mode'
                : 'Switch to dark mode',
            foregroundColor: invertInvertColorsStrong(context),
            backgroundColor: invertInvertColorsTheme(context),
            elevation: 5.0,
            onPressed: () {
              DynamicTheme.of(context).setBrightness(
                  Theme.of(context).brightness == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark);
            },
          ),
        ),
      ),
    );
  }
}
