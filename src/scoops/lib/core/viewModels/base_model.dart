import 'package:flutter/cupertino.dart';
import 'package:scoops/core/enums/view_state.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.Ready;

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
}
