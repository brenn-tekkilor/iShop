import 'package:flutter/material.dart';
import 'package:ishop/utils/ui_helpers.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: invertInvertColorsStrong(context),
        body: Flex(
            direction: Axis.vertical,
            textDirection: TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  top: 50.0,
                ),
              ),
              Expanded(
                child: Text('TODO'),
              ),
            ]),
      ),
    );
  }
}
