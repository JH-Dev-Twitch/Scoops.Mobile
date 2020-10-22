import 'package:flutter/material.dart';
import 'package:scoops/models/establishment.dart';
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
  List<BeverageGroup> groups = [
    BeverageGroup('Cider',
        'https://images.immediate.co.uk/production/volatile/sites/22/2019/09/How-to-make-your-own-cider--ceca08e.jpg?quality=90&resize=768%2C574'),
    BeverageGroup('Lager',
        'https://www.irishpubsglobal.com/wp-content/uploads/2018/01/Open-Gate-Pure-Brew_bottle-glass-shot-e1516376900661.jpg'),
    BeverageGroup('Stout',
        'https://cf.bstatic.com/data/xphoto/1182x887/554/55450596.jpg?size=S'),
    BeverageGroup('Whiskeys',
        'https://www.securingindustry.com/assets/97/hero_1152x585.jpg')
  ];
  List<Filter> filters = [
    new Filter('Pubs', true),
    new Filter('Restaraunts', false),
    new Filter('Bar', false),
    new Filter('Cafe', false),
    new Filter('Brewery', false),
    new Filter('Hotel', false),
  ];
  Establishment establishment = new Establishment(
      name: 'Dew Drop Inn',
      imageUrl:
          'https://connachttribune.ie/wp-content/uploads/2017/06/The-Dew-Drop-Inn1.jpg',
      establishmentType: 'Pub',
      amenities: ['Live music', 'Comedy'],
      rating: EstablishmentRatingSummary(overallRating: 4.8, ratings: 40));
  void tapped(int index) {
    setState(() {
      for (var i = 0; i <= filters.length - 1; i++) {
        filters[i].selected = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: new Row(
      children: <Widget>[
        Expanded(
            child: Column(children: [
          buildNavbar(),
          ChipFilter(
            filters: filters,
            tapped: tapped,
          ),
          SizedBox(
            height: 100,
            child: new ListView.separated(
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: 10,
              ),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(10),
              itemCount: groups.length,
              itemBuilder: (BuildContext ctxt, int index) {
                var group = groups[index];
                return ImageTile(
                  text: group.text,
                  imageUrl: group.imageUrl,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              style: TextStyle(fontSize: 15),
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
                        separatorBuilder: (BuildContext ctx, int index) =>
                            VerticalDivider(
                              width: 10,
                              color: Colors.white,
                            ),
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        itemBuilder: (BuildContext builder, int index) =>
                            EstablishmentCard(
                              establishment: establishment,
                              tag: 'Popular',
                            ))),
              ],
            ),
          )
        ]))
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    )));
  }

  Container buildNavbar() {
    return Container(
        color: new Color(0xff166FFF),
        child: Padding(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Row(
              children: [
                LocationWidget(
                  locationName: 'Galway, Ireland',
                ),
                Spacer(),
                ActionsWidget(
                    avatarUrl:
                        'https://avatars2.githubusercontent.com/u/11406932?s=400&u=1daa67e7dd746084a56c68a0de041acac5c4d652&v=4')
              ],
            )));
  }
}

class BeverageGroup {
  String text;
  String imageUrl;

  BeverageGroup(this.text, this.imageUrl);
}
