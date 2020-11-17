import 'package:flutter/material.dart';
import 'package:scoops/core/data/establishment/establishment_filters.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/infrastructure/app_locator.dart';
import 'package:scoops/core/infrastructure/routing/routes.dart';
import 'package:scoops/core/services/establishment_service.dart';
import 'package:scoops/core/viewModels/base_model.dart';
import 'package:scoops/ui/models/Selection.dart';

class SearchModel extends BaseModel {
  List<Selection> amenities = new List<Selection>();
  List<Selection> establishmentTypes = new List<Selection>();
  String selectedType;
  final EstablishmentService _establishmentService =
      locator<EstablishmentService>();

  void handleSelection(int index) {
    amenities[index].selected = !amenities[index].selected;
    setState(ViewState.Ready);
  }

  void handleTypeSelection(int index) {
    establishmentTypes[index].selected = !establishmentTypes[index].selected;
    setState(ViewState.Ready);
  }

  Future loadData() async {
    try {
      setState(ViewState.Loading);
      var results = await _establishmentService.loadAmenitiesAsync();
      amenities = results
          .map((doc) => Selection(value: doc.name, selected: false))
          .toList();
      var types = await _establishmentService.loadEstablishmentTypesAsync();
      establishmentTypes =
          types.map((e) => Selection(value: e.name, selected: false)).toList();
      setState(ViewState.Ready);
    } catch (e) {
      var test = e;
    }
  }

  void onTypeChanged(String value) {
    selectedType = value;
    setState(ViewState.Ready);
  }

  void close(BuildContext context) => Navigator.pop(context);
  void applyFilters(BuildContext context) {
    var filters = EstablishmentFilters(
        this
            .amenities
            .where((amenity) => amenity.selected)
            .map((e) => e.value)
            .toList(),
        this
            .establishmentTypes
            .where((element) => element.selected)
            .map((e) => e.value)
            .toList());
    //todo send to page
    Navigator.pop(context);
  }
}
