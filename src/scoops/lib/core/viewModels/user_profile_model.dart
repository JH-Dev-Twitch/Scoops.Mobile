import 'package:scoops/core/infrastructure/app_locator.dart';
import 'package:scoops/core/services/authentication_service.dart';
import 'package:scoops/core/viewModels/base_model.dart';

class UserProfileModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  Future<bool> logOutAsync() async {
    return await _authenticationService.logOutAsync();
  }
}
