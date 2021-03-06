import 'package:flutter/cupertino.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/infrastructure/app_locator.dart';
import 'package:scoops/core/infrastructure/logging/logging_service.dart';

class BaseModel extends ChangeNotifier {
  final _loggingService = locator<LoggingService>();
  ViewState _state = ViewState.Ready;
  String errorMessage = "There was an error";

  ViewState get state => _state;

  /// Updates the Models state to one of the predefined states of type [state].
  ///
  /// This will trigger all Consumers to update
  ///
  /// [state] An enum which represents a Models state => Ready, Loading, Error
  void setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setErrorState({String message = "There was an error"}) {
    errorMessage = message;
    setState(ViewState.Error);
  }

  void fakeError(String message) => setErrorState();

  Future trackEvent(String event) async =>
      _loggingService.trackEventAsync(event);
}
