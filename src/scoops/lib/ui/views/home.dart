import 'package:flutter/material.dart';
import 'package:scoops/ui/widgets/common/actionsWidget.dart';
import 'package:scoops/ui/widgets/common/locationWidget.dart';

class ScoopsHomePage extends StatefulWidget {
  ScoopsHomePage({Key key}) : super(key: key);

  @override
  _ScoopsHomePageState createState() => _ScoopsHomePageState();
}

class _ScoopsHomePageState extends State<ScoopsHomePage> {
  @override
  Widget build(BuildContext context) {
    List<Filter> filters = [
      new Filter('Pubs', true),
      new Filter('Restaraunts', false),
      new Filter('Bar', false),
      new Filter('Cafe', false),
      new Filter('Brewery', false),
      new Filter('Hotel', false),
    ];
    return Scaffold(
        body: SafeArea(
            child: new Row(
      children: <Widget>[
        Expanded(
            child: Column(children: [
          Container(
              color: Colors.blue,
              child: Padding(
                  padding: EdgeInsets.all(10),
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
                  ))),
          SizedBox(
            height: 80,
            child: new ListView.separated(
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: 10,
              ),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.all(10),
              itemCount: filters.length,
              itemBuilder: (BuildContext ctxt, int index) {
                var filter = filters[index];
                return Chip(
                    backgroundColor:
                        filter.selected ? Colors.blue : Colors.transparent,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    label: new Text(
                      filter.title,
                      style: TextStyle(
                          color: filter.selected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ));
              },
            ),
          )
        ])),
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    )));
  }
}

class Filter {
  String title;
  bool selected;

  Filter(this.title, this.selected);
}
