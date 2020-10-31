import 'package:scoops/core/data/models/beverageGroup.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/infrstructure/app_locator.dart';
import 'package:scoops/core/services/beverageService.dart';
import 'package:scoops/core/viewModels/base_model.dart';

class ScoopsHomeModel extends BaseModel {
  BeverageService _service = locator<BeverageService>();

  List<BeverageGroup> beverageGroups;

  Future getBeverageGroupsAsync() async {
    setState(ViewState.Loading);
    this.beverageGroups = await _service.getBeverageGroupsAsync();
    setState(ViewState.Ready);
  }
}
