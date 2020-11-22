import 'package:flutter/material.dart';
import 'package:ishop/app/login/login_provider.dart';
import 'package:ishop/app_router.dart';
import 'package:ishop/com/basic_button.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appBarText = Theme.of(context)?.textTheme.bodyText1;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        title: Text('iShop'),
        actions: [
          Container(
              height: 50.0,
              width: size.width / 3,
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              alignment: Alignment.centerRight,
              child: SizedBox.expand(
                child: TextButton(
                  child: Text('CHOOSE PICKUP!', style: appBarText),
                  onPressed: () => Navigator.of(context)?.pushNamed('places',
                      arguments: RouteArguments(
                          isAuthorized:
                              Provider.of<LoginProvider>(context, listen: false)
                                  .isAuthorized)),
                ),
              )),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Please choose a place.',
              style: Theme.of(context)?.typography.black.headline2,
            ),
            BasicButton(
              text: 'DEV',
              onTap: () => Navigator.of(context)?.pushNamed('dev',
                  arguments: RouteArguments(
                      isAuthorized:
                          Provider.of<LoginProvider>(context, listen: false)
                              .isAuthorized)),
            )
          ],
        ),
      ),
    );
  }
}
