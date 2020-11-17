import 'package:flutter/material.dart';
import 'package:scoops/core/viewModels/search_model.dart';
import 'package:scoops/ui/models/Selection.dart';
import 'package:scoops/ui/styling/app_style.dart';
import 'package:scoops/ui/views/base_view.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SearchModel>(
        onModelReady: (model) async => await model.loadData(),
        builder: (context, model, child) => Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () => model.close(context),
                            child: const Icon(
                              Icons.close_rounded,
                              color: Colors.black,
                            ),
                          ),
                          Center(
                            child: const Text(
                              'Filters',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Establishment Types',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Wrap(children: buildEstablishmentTypeChips(model))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                        child: const Text(
                          'Amenities',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      Wrap(children: buildChips(model)),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: RaisedButton(
                          padding: const EdgeInsets.all(15),
                          onPressed: () => model.applyFilters(context),
                          child: const Text('Apply'),
                          color: AppStyles.primaryTheme.primaryColor,
                          textColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  List<Widget> buildChips(SearchModel model) {
    return new List<Widget>.generate(model.amenities.length, (index) {
      Selection amenity = model.amenities[index];
      return GestureDetector(
        onTap: () => model.handleSelection(index),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Chip(
                avatar: buildSelectedIcon(amenity.selected),
                label: Text(
                  amenity.value,
                  style: amenity.selected
                      ? const TextStyle(color: Colors.white)
                      : null,
                ),
                backgroundColor: amenity.selected
                    ? AppStyles.primaryTheme.primaryColor
                    : null)),
      );
    });
  }

  List<Widget> buildEstablishmentTypeChips(SearchModel model) {
    return new List<Widget>.generate(model.establishmentTypes.length, (index) {
      Selection amenity = model.establishmentTypes[index];
      return GestureDetector(
        onTap: () => model.handleTypeSelection(index),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Chip(
                avatar: buildSelectedIcon(amenity.selected),
                label: Text(
                  amenity.value,
                  style: amenity.selected
                      ? const TextStyle(color: Colors.white)
                      : null,
                ),
                backgroundColor: amenity.selected ? Colors.pink : null)),
      );
    });
  }

  Widget buildSelectedIcon(bool selected) => selected
      ? const Icon(
          Icons.check,
          color: Colors.white,
          size: 18,
        )
      : null;

  List<DropdownMenuItem> buildDropDownItems(List<String> establishmentTypes) =>
      establishmentTypes
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList();
}
