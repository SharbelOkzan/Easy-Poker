import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator.config.dart';

final getIt = GetIt.instance;
// I'm aware that I can use Riverpod to register and inject dependencies.
// Using injectable is just a personal choice (less code)
@InjectableInit()
void configureDependencies() => getIt.init();
