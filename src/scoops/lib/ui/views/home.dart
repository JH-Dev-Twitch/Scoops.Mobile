import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoops/core/data/models/establishmentType.dart';
import 'package:scoops/core/data/models/user.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/viewModels/scoops_home_model.dart';
import 'package:scoops/ui/views/base_view.dart';
import 'package:scoops/ui/widgets/common/actionsWidget.dart';
import 'package:scoops/ui/widgets/common/locationWidget.dart';
import 'package:scoops/ui/widgets/establishment/establishmentCardWidget.dart';

class ScoopsHomePage extends StatefulWidget {
  ScoopsHomePage({Key key}) : super(key: key);

  @override
  _ScoopsHomePageState createState() => _ScoopsHomePageState();
}

class _ScoopsHomePageState extends State<ScoopsHomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ScoopsHomeModel>(
      onModelReady: (model) async => await model.loadData(),
      builder: (context, model, child) => Scaffold(
          body: SafeArea(
              child: model.state == ViewState.Loading
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                                  SizedBox(
                                    height: 120,
                                    child: new ListView.separated(
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              SizedBox(
                                        width: 30,
                                      ),
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.all(10),
                                      itemCount:
                                          model.establishmentTypes.length,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        var type =
                                            model.establishmentTypes[index];
                                        return buildEstablishmentCard(type);
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
                                                itemCount: model
                                                    .featuredEstablishments
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext builder,
                                                            int index) =>
                                                        EstablishmentCard(
                                                          establishment: model
                                                                  .featuredEstablishments[
                                                              index],
                                                          tag: null,
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

  Widget buildEstablishmentCard(EstablishmentType type) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: buildBackgroundColor(type.name),
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: Icon(
              buildIcon(type.name),
              color: Colors.white,
              size: 20,
            ),
          ),
          Text(
            type.name,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          )
        ],
      );

  IconData buildIcon(String name) {
    switch (name) {
      case "Hotel":
        return Icons.hotel;
      case "Pub":
        return Icons.local_drink_rounded;
      case "Gin Bar":
        return Icons.nightlife;
      case "Nightclub":
        return Icons.nightlife;
      case "Brewery":
        return Icons.restaurant_rounded;
      case "Restaraunt":
        return Icons.restaurant_rounded;
      default:
    }
  }

  Color buildBackgroundColor(String name) {
    switch (name) {
      case "Hotel":
        return Colors.blueAccent;
      case "Pub":
        return Colors.green;
      case "Gin Bar":
        return Colors.pinkAccent;
      case "Nightclub":
        return Colors.purpleAccent;
      case "Brewery":
        return Colors.orangeAccent;
      case "Restaraunt":
        return Colors.redAccent;
      default:
    }
  }
}
