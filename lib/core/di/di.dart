import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:privat_test_task/core/di/di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();
