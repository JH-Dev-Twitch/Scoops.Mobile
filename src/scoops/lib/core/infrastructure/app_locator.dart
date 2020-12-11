import 'package:get_it/get_it.dart';
import 'package:scoops/core/infrastructure/logging/logging_service.dart';
import 'package:scoops/core/services/authentication_service.dart';
import 'package:scoops/core/services/beverage_service.dart';
import 'package:scoops/core/services/establishment_service.dart';
import 'package:scoops/core/services/location_service.dart';
import 'package:scoops/core/services/oss_contributions_service.dart';
import 'package:scoops/core/services/user_account_service.dart';
import 'package:scoops/core/viewModels/app_settings_model.dart';
import 'package:scoops/core/viewModels/login_model.dart';
import 'package:scoops/core/viewModels/oss_contibutions_model.dart';
import 'package:scoops/core/viewModels/scoops_home_model.dart';
import 'package:scoops/core/viewModels/search_model.dart';
import 'package:scoops/core/viewModels/user_preferences_model.dart';
import 'package:scoops/core/viewModels/user_profile_model.dart';

GetIt locator = GetIt.instance;

void initializeServiceLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => BeverageService());
  locator.registerLazySingleton(() => EstablishmentService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => UserAccountService());
  locator.registerLazySingleton(() => OSSContributionsService());
  locator.registerLazySingleton(() => LoggingService());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => ScoopsHomeModel());
  locator.registerFactory(() => UserProfileModel());
  locator.registerFactory(() => SearchModel());
  locator.registerFactory(() => UserPreferencesModel());
  locator.registerFactory(() => AppSettingsModel());
  locator.registerFactory(() => OSSContributionsModel());
}
