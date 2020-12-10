import 'package:flutter/material.dart';
import 'package:ishop/app/app_provider.dart';
import 'package:ishop/app/login/auth_provider.dart';
import 'package:ishop/com/basic_button.dart';
import 'package:ishop/data/enums/preferred_place_options.dart';
import 'package:ishop/data/model/place_details.dart';
import 'package:ishop/util/extensions/string_extensions.dart';
import 'package:provider/provider.dart';

/// The apps home page after login
class HomeView extends StatelessWidget {
  /// home page const Constructor
  const HomeView({Key? key}) : super(key: key);
  void _goToPlaces(BuildContext context) =>
      Navigator.of(context)?.pushNamed('places', arguments: <String, dynamic>{
        'auth': context.read<AuthProvider>(),
      });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          actions: [
            if (context.watch<AppProvider>().preferredPlace is PlaceDetails)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text('iShop @ ',
                            style: Theme.of(context).typography.white.caption),
                      ),
                      DropdownButton<PreferredPlaceOptions?>(
                        underline: const ColoredBox(
                            color: Colors.deepPurple,
                            child: SizedBox(
                              height: 2,
                            )),
                        hint: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              context
                                      .watch<AppProvider>()
                                      .preferredPlace
                                      ?.name
                                      .clipStart(
                                          maxLength: 16, trailing: '...') ??
                                  '',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .subtitle1
                                  ?.copyWith(
                                      color: Colors.blue[100],
                                      fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        items: _placeOptions.keys
                            .map<DropdownMenuItem<PreferredPlaceOptions>>(
                                (k) => DropdownMenuItem(
                                      value: k,
                                      child: Text(_placeOptions[k] ?? '',
                                          style: Theme.of(context)
                                              .accentTextTheme
                                              .subtitle2),
                                    ))
                            .toList(),
                        icon: Icon(
                          Icons.local_grocery_store_outlined,
                          size: 20,
                          color: Colors.blue[100],
                        ),
                        onChanged: (value) => value ==
                                PreferredPlaceOptions.change
                            ? _goToPlaces(context)
                            : Provider.of<AppProvider>(context, listen: false)
                                .startNavigation(),
                      ),
                    ],
                  ),
                ),
              )
            else
              TextButton(
                onPressed: () => _goToPlaces(context),
                child: const Text('FIND A PLACE'),
              ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Please choose a place.',
                style: Theme.of(context).typography.black.headline2,
              ),
              BasicButton(
                  text: 'DEV',
                  onTap: () => Navigator.of(context)?.pushNamed('dev',
                          arguments: <String, dynamic>{
                            'auth': Provider.of<AuthProvider>(context)
                          })),
            ],
          ),
        ),
      );
  static const _placeOptions = <PreferredPlaceOptions, String>{
    PreferredPlaceOptions.change: 'CHANGE',
    PreferredPlaceOptions.navigate: 'NAVIGATE'
  };
}
