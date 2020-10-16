import 'package:flutter/material.dart';

class ScoopsHomePage extends StatefulWidget {
  ScoopsHomePage({Key key}) : super(key: key);

  @override
  _ScoopsHomePageState createState() => _ScoopsHomePageState();
}

class _ScoopsHomePageState extends State<ScoopsHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
              )))
    ])));
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({Key key, this.locationName}) : super(key: key);

  final String locationName;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.place,
            size: 15,
            color: Colors.white,
          )),
      Text(
        locationName,
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      )
    ]);
  }
}

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({Key key, this.avatarUrl}) : super(key: key);
  final String avatarUrl;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
        maxRadius: 15,
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        Icons.map,
        size: 25,
        color: Colors.white,
      ),
      SizedBox(
        width: 10,
      ),
      Icon(
        Icons.search,
        size: 25,
        color: Colors.white,
      )
    ]);
  }
}
