import 'package:get_it/get_it.dart';
import 'package:ishop/services/login_service.dart';
import 'package:ishop/services/places_service.dart';
import 'package:ishop/views/home/home_model.dart';
import 'package:ishop/views/login/login_model.dart';
import 'package:ishop/views/map/map_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.allowReassignment = true;
  if (!!!locator.isRegistered<LoginService>()) {
    locator.registerLazySingleton<LoginService>(() => LoginService.initial());
  }
  if (!!!locator.isRegistered<PlacesService>()) {
    locator.registerSingletonAsync<PlacesService>(
        () async => await PlacesService.initial().initialize());
  }
  locator.registerFactory<MapModel>(() => MapModel.initial());
  locator.registerFactory<LoginModel>(() => LoginModel.initial());
  locator.registerFactory<HomeModel>(() => HomeModel());
}
