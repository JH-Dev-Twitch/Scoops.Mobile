import 'package:flutter/material.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/viewModels/user/user_preferences_model.dart';
import 'package:scoops/ui/models/Selection.dart';
import 'package:scoops/ui/styling/app_style.dart';
import 'package:scoops/ui/views/base_view.dart';
import 'package:scoops/ui/widgets/common/plain_app_bar.dart';
import 'package:scoops/ui/widgets/common/selection_chip.dart';

class UserPreferencesView extends StatelessWidget {
  UserPreferencesView({Key key}) : super(key: key);
  final TextStyle _textStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  final EdgeInsets _textPadding = EdgeInsets.symmetric(vertical: 10);
  @override
  Widget build(BuildContext context) {
    return BaseView<UserPreferencesModel>(
      onModelReady: (model) async => await model.loadPageData(),
      builder: (context, model, child) => Scaffold(
        appBar: PlainAppBar.buildAppBar(context, title: 'User Preferences'),
        body: SafeArea(
            child: model.state == ViewState.Loading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: _textPadding,
                          child:
                              Text('Establishment Types:', style: _textStyle),
                        ),
                        Wrap(
                          children: buildEstablishmentTypeChips(model),
                        ),
                        Padding(
                          padding: _textPadding,
                          child: Text('Beverage Groups:', style: _textStyle),
                        ),
                        Wrap(
                          children: buildGroupsChips(model),
                        ),
                        Padding(
                          padding: _textPadding,
                          child: Text('Establishment Amenities:',
                              style: _textStyle),
                        ),
                        Wrap(
                          children: buildAmenityChips(model),
                        ),
                        Spacer(),
                        RaisedButton(
                          onPressed: () async {
                            var result = await model.savePreferences();
                            if (result) {
                              Navigator.pop(context);
                            } else {
                              var snackBar = SnackBar(
                                  content: Text('There was an error saving'));
                              Scaffold.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Save Changes',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          color: AppStyles.primaryTheme.primaryColor,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  )),
      ),
      child: PlainAppBar.buildAppBar(context, title: 'User Preferences'),
    );
  }

  List<Widget> buildEstablishmentTypeChips(UserPreferencesModel model) {
    return new List<Widget>.generate(model.types.length, (index) {
      Selection type = model.types[index];
      return SelectionChip(type, () => model.handleTypeSelection(index),
          selectedColor: AppStyles.primaryTheme.primaryColor);
    });
  }

  List<Widget> buildGroupsChips(UserPreferencesModel model) {
    return new List<Widget>.generate(model.groups.length, (index) {
      Selection group = model.groups[index];
      return SelectionChip(group, () => model.handleGroupSelection(index),
          selectedColor: Colors.pink);
    });
  }

  List<Widget> buildAmenityChips(UserPreferencesModel model) {
    return new List<Widget>.generate(model.amenities.length, (index) {
      Selection amenity = model.amenities[index];
      return SelectionChip(amenity, () => model.handleSelection(index),
          selectedColor: Colors.green);
    });
  }
}
