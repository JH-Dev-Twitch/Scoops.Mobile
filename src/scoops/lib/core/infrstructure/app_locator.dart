import 'package:get_it/get_it.dart';
import 'package:scoops/core/services/authentication_service.dart';
import 'package:scoops/core/viewModels/login_model.dart';

GetIt locator = GetIt.instance;

void initializeServiceLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerFactory(() => LoginModel());
}
