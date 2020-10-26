import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:ishop/app/services/locator.config.dart';

final locator = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
)
void configureDependencies() => $initGetIt(locator);
