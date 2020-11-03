import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/infrastructure/app_locator.dart';
import 'package:scoops/core/services/authentication_service.dart';
import 'package:scoops/core/viewModels/base_model.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<bool> login() async {
    setState(ViewState.Loading);
    var result = await _authenticationService.login();
    setState(ViewState.Ready);
    return result;
  }
}
