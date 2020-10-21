import 'package:ishop/app/service_locator.dart';
import 'package:ishop/services/places_service.dart';
import 'package:ishop/views/base/base_model.dart';

class PlacesModel extends BaseModel {
  PlacesModel() : srv = locator<PlacesService>();

  final PlacesService srv;

  @override
  void dispose() {
    super.dispose();
  }

  //#endregion

}
