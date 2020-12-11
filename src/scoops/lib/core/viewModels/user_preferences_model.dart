import 'package:scoops/core/data/user/user_preferences.dart';
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
    try {
      setState(ViewState.Loading);
      var prefs = await _userAccountService.getUserSettings();
      if (prefs == null) {
        await _userAccountService.createEmptyPrefs();
        prefs = UserPreferences.empty();
      }
      await Future.wait([
        loadAmenities(prefs.amenities),
        loadEstablishmentTypes(prefs.establishmentTypes),
        loadBeverageGroups(prefs.beverageGroups)
      ]);

      setState(ViewState.Ready);
      await trackEvent("User Preferences");
    } catch (e) {
      setState(ViewState.Error);
    }
  }

  Future loadAmenities(List<String> prefs) async {
    prefs = nullCheckPrefs(prefs);
    var _amenities = await _establishmentService.loadAmenitiesAsync();
    amenities = _amenities
        .map((e) => Selection(value: e.name, selected: prefs.contains(e.name)))
        .toList();
  }

  Future loadEstablishmentTypes(List<String> prefs) async {
    prefs = nullCheckPrefs(prefs);
    var establishmentTypes =
        await _establishmentService.loadEstablishmentTypesAsync();
    types = establishmentTypes
        .map((e) => Selection(value: e.name, selected: prefs.contains(e.name)))
        .toList();
  }

  Future loadBeverageGroups(List<String> prefs) async {
    prefs = nullCheckPrefs(prefs);
    var beverageGroups = await _beverageService.getBeverageGroupsAsync();
    groups = beverageGroups
        .map((e) => Selection(value: e.name, selected: prefs.contains(e.name)))
        .toList();
  }

  List<String> nullCheckPrefs(List<String> prefs) =>
      prefs = prefs ?? List<String>.empty();

  Future<bool> savePreferences() async {
    try {
      setState(ViewState.Loading);
      var result = await _userAccountService.savePreferences(mapPrefs());
      setState(ViewState.Ready);
      return result;
    } catch (e) {
      setState(ViewState.Error);
      return false;
    }
  }

  UserPreferences mapPrefs() {
    var amenities =
        this.amenities.where((am) => am.selected).map((e) => e.value).toList();
    var estTypes =
        this.types.where((am) => am.selected).map((e) => e.value).toList();
    var bevGroups =
        this.groups.where((am) => am.selected).map((e) => e.value).toList();

    return UserPreferences.populate(
        amenities: amenities,
        establishmentTypes: estTypes,
        beverageGroups: bevGroups);
  }
}
