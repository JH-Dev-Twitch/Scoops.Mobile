import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoops/core/data/models/establishment.dart';
import 'package:scoops/core/data/models/user.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/viewModels/scoops_home_model.dart';
import 'package:scoops/ui/views/base_view.dart';
import 'package:scoops/ui/widgets/common/actionsWidget.dart';
import 'package:scoops/ui/widgets/common/chipFilterWidget.dart';
import 'package:scoops/ui/widgets/common/imageTileWidget.dart';
import 'package:scoops/ui/widgets/common/locationWidget.dart';
import 'package:scoops/ui/widgets/establishment/establishmentCardWidget.dart';

class ScoopsHomePage extends StatefulWidget {
  ScoopsHomePage({Key key}) : super(key: key);

  @override
  _ScoopsHomePageState createState() => _ScoopsHomePageState();
}

class _ScoopsHomePageState extends State<ScoopsHomePage> {
  Establishment establishment = new Establishment(
      name: 'Dew Drop Inn',
      imageUrl:
          'https://connachttribune.ie/wp-content/uploads/2017/06/The-Dew-Drop-Inn1.jpg',
      establishmentType: 'Pub',
      amenities: ['Live music', 'Comedy'],
      rating: EstablishmentRatingSummary(overallRating: 4.8, ratings: 40));

  @override
  Widget build(BuildContext context) {
    return BaseView<ScoopsHomeModel>(
      onModelReady: (model) async => await model.loadData(),
      builder: (context, model, child) => Scaffold(
          body: SafeArea(
              child: model.state == ViewState.Loading
                  ? Column(
                      children: [
                        Center(child: CircularProgressIndicator()),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                            child: Column(children: [
                          buildNavbar(
                              model.state,
                              Provider.of<AppUser>(context).imageUrl,
                              model.locationName),
                          Column(
                            children: [
                              Column(
                                children: [
                                  ChipFilter(
                                    filters: model.establishmentTypes,
                                    tapped: model.tapped,
                                  ),
                                  SizedBox(
                                    height: 100,
                                    child: new ListView.separated(
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              SizedBox(
                                        width: 10,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.all(10),
                                      itemCount: model.beverageGroups.length,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        var group = model.beverageGroups[index];
                                        return ImageTile(
                                          text: group.name,
                                          imageUrl: group.imageUrl,
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 0, 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Featured',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                            FlatButton(
                                                padding: EdgeInsets.zero,
                                                textColor: Colors.grey,
                                                onPressed: () => {},
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'View all',
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    Icon(
                                                      Icons.chevron_right,
                                                      size: 25,
                                                    )
                                                  ],
                                                ))
                                          ],
                                        ),
                                        SizedBox(
                                            height: 300,
                                            child: ListView.separated(
                                                separatorBuilder:
                                                    (BuildContext ctx,
                                                            int index) =>
                                                        VerticalDivider(
                                                          width: 10,
                                                          color: Colors.white,
                                                        ),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: 2,
                                                itemBuilder:
                                                    (BuildContext builder,
                                                            int index) =>
                                                        EstablishmentCard(
                                                          establishment:
                                                              establishment,
                                                          tag: 'Popular',
                                                        ))),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ])),
                      ],
                    ))),
    );
  }

  Container buildNavbar(ViewState state, String imageUrl, String location) {
    return Container(
        color: new Color(0xff166FFF),
        child: Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Row(
              children: [
                LocationWidget(
                  locationName: state == ViewState.Ready ? location : "Loading",
                ),
                Spacer(),
                state == ViewState.Loading
                    ? null
                    : ActionsWidget(avatarUrl: imageUrl)
              ],
            )));
  }
}
