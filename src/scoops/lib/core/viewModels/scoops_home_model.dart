import 'package:scoops/core/data/models/beverageGroup.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/infrastructure/app_locator.dart';
import 'package:scoops/core/services/beverage_service.dart';
import 'package:scoops/core/services/establishment_service.dart';
import 'package:scoops/core/services/location_service.dart';
import 'package:scoops/core/viewModels/base_model.dart';
import 'package:scoops/ui/widgets/common/chipFilterWidget.dart';

class ScoopsHomeModel extends BaseModel {
  BeverageService _service = locator<BeverageService>();
  EstablishmentService _establishmentService = locator<EstablishmentService>();
  LocationService _locationService = locator<LocationService>();
  String locationName;
  List<BeverageGroup> beverageGroups;
  List<Filter> establishmentTypes;

  Future loadData() async {
    setState(ViewState.Loading);
    this.beverageGroups = await _service.getBeverageGroupsAsync();
    await loadEstablishmentTypesAsync();
    locationName = await _locationService.getLocation();
    setState(ViewState.Ready);
  }

  Future loadEstablishmentTypesAsync() async {
    var types = await _establishmentService.loadEstablishmentTypesAsync();
    establishmentTypes = new List<Filter>();
    types.asMap().forEach((index, type) =>
        establishmentTypes.add(Filter(type.id, type.name, index == 0)));
  }

  void tapped(int index) {
    for (var i = 0; i <= establishmentTypes.length - 1; i++) {
      establishmentTypes[i].selected = i == index;
    }
    setState(ViewState.Ready);
  }
}
