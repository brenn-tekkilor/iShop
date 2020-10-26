import 'package:injectable/injectable.dart';
import 'package:ishop/app/services/locator.dart';
import 'package:ishop/app/services/router.gr.dart';
import 'package:ishop/components/base/base_model.dart';
import 'package:ishop/components/places/places_service.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class PlacesModel extends BaseModel {
  PlacesModel()
      : srv = locator<PlacesService>(),
        _navigationService = locator<NavigationService>();
  @factoryMethod
  factory PlacesModel.initial() {
    return PlacesModel();
  }

  final PlacesService srv;
  final NavigationService _navigationService;

  Future<void> navigateToPlacesMap() =>
      _navigationService.navigateTo(Routes.mapView);

  @override
  void dispose() {
    super.dispose();
  }

  //#endregion

}
