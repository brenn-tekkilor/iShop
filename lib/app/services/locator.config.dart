// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:ishop/components/home/home_model.dart';
import 'package:ishop/components/login/login_model.dart';
import 'package:ishop/components/login/login_service.dart';
import 'package:ishop/components/map/map_model.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ishop/components/places/places_model.dart';
import 'package:ishop/components/places/places_service.dart';
import 'package:ishop/app/services/service_locator.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final serviceLocator = _$ServiceLocator();
  gh.lazySingleton<DialogService>(() => serviceLocator.dialogService);
  gh.factory<HomeModel>(() => HomeModel.initial());
  gh.factory<LoginModel>(() => LoginModel.initial());
  gh.lazySingleton<LoginService>(() => LoginService.initial());
  gh.factory<MapModel>(() => MapModel.initial());
  gh.lazySingleton<NavigationService>(() => serviceLocator.navigationService);
  gh.factory<PlacesModel>(() => PlacesModel.initial());
  gh.lazySingleton<PlacesService>(() => PlacesService.initial());
  return get;
}

class _$ServiceLocator extends ServiceLocator {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
