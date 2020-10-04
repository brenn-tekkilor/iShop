import 'package:flutter/material.dart';
import 'package:ishop/pages/poi/poi_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget get _updatePOIPrompt {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Please choose a store.',
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }

  // All this method does is bring up the form page.
  void _updatePOI(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return POIPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iShop'),
      ),
      body: _updatePOIPrompt,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _updatePOI(context),
        child: Icon(Icons.edit),
      ),
    );
  }
}
