import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:ishop/app/services/locator.dart';
import 'package:ishop/app/services/router.gr.dart';
import 'package:ishop/components/base/base_model.dart';
import 'package:ishop/components/places/places_service.dart';
import 'package:ishop/core/models/place.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class HomeModel extends BaseModel {
  HomeModel()
      : _srv = locator<PlacesService>(),
        _navigationService = locator<NavigationService>();
  @factoryMethod
  factory HomeModel.initial() {
    return HomeModel();
  }

  final PlacesService _srv;
  final NavigationService _navigationService;

  ValueNotifier<Place> get placeNotifier => _srv.placeNotifier;

  Future<void> navigateToPlacesView() async =>
      await _navigationService.navigateTo(Routes.placesView);
}
