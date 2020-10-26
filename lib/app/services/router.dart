import 'package:auto_route/auto_route_annotations.dart';
import 'package:ishop/components/home/home_view.dart';
import 'package:ishop/components/login/login_view.dart';
import 'package:ishop/components/map/map_view.dart';
import 'package:ishop/components/places/places_view.dart';

@MaterialAutoRouter(routes: <MaterialRoute>[
  MaterialRoute<LoginView>(page: LoginView, initial: true),
  MaterialRoute<HomeView>(page: HomeView),
  MaterialRoute<PlacesView>(page: PlacesView),
  MaterialRoute<MapView>(page: MapView),
])
class $AppRoutes {}
