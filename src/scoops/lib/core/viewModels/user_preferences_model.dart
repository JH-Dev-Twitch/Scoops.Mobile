import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/infrastructure/app_locator.dart';
import 'package:scoops/core/services/beverage_service.dart';
import 'package:scoops/core/services/establishment_service.dart';
import 'package:scoops/core/services/user_account_service.dart';
import 'package:scoops/core/viewModels/base_model.dart';
import 'package:scoops/ui/models/Selection.dart';

class UserPreferencesModel extends BaseModel {
  final UserAccountService _userAccountService = locator<UserAccountService>();
  final EstablishmentService _establishmentService =
      locator<EstablishmentService>();
  final BeverageService _beverageService = locator<BeverageService>();

  List<Selection> groups = new List.empty();
  List<Selection> amenities = new List.empty();
  List<Selection> types = new List.empty();

  void handleSelection(int index) {
    amenities[index].selected = !amenities[index].selected;
    setState(ViewState.Ready);
  }

  void handleTypeSelection(int index) {
    types[index].selected = !types[index].selected;
    setState(ViewState.Ready);
  }

  void handleGroupSelection(int index) {
    groups[index].selected = !groups[index].selected;
    setState(ViewState.Ready);
  }

  //UserPreferences userPreferences;

  Future loadPageData() async {
    setState(ViewState.Loading);
    var prefs = await _userAccountService.getUserSettings();
    var _amenities = await _establishmentService.loadAmenitiesAsync();
    var establishmentTypes =
        await _establishmentService.loadEstablishmentTypesAsync();
    var beverageGroups = await _beverageService.getBeverageGroupsAsync();
    amenities = _amenities
        .map((e) => Selection(
            value: e.name, selected: prefs.amenities.contains(e.name)))
        .toList();
    types = establishmentTypes
        .map((e) => Selection(
            value: e.name, selected: prefs.establishmentTypes.contains(e.name)))
        .toList();
    groups = beverageGroups
        .map((e) => Selection(
            value: e.name, selected: prefs.beverageGroups.contains(e.name)))
        .toList();
    setState(ViewState.Ready);
  }

  Future<bool> savePreferences() async {
    try {
      setState(ViewState.Loading);
      var result = await _userAccountService.savePreferences(mapPrefs());
      setState(ViewState.Ready);
      return result;
    } catch (e) {
      var test = e;
    }
  }

  Map<String, List<dynamic>> mapPrefs() => {
        'amenities': this
            .amenities
            .where((am) => am.selected)
            .map((e) => e.value)
            .toList(),
        'establishment_types':
            this.types.where((am) => am.selected).map((e) => e.value).toList(),
        'beverage_groups':
            this.groups.where((am) => am.selected).map((e) => e.value).toList()
      };
}
