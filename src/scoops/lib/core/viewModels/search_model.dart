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

  final EstablishmentService _establishmentService =
      locator<EstablishmentService>();

  void handleSelection(int index) {
    amenities[index].selected = !amenities[index].selected;
    setState(ViewState.Ready);
  }

  Future loadData() async {
    try {
      setState(ViewState.Loading);
      var results = await _establishmentService.loadAmenitiesAsync();
      amenities = results
          .map((doc) => Selection(value: doc.name, selected: false))
          .toList();
      setState(ViewState.Ready);
    } catch (e) {
      var test = e;
    }
  }

  void close(BuildContext context) => Navigator.pop(context);
  void applyFilters(BuildContext context) {
    var filters = EstablishmentFilters(this
        .amenities
        .where((amenity) => amenity.selected)
        .map((e) => e.value)
        .toList());
    Navigator.pop(context);
  }
}
