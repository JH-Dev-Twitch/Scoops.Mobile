import 'package:flutter/material.dart';
import 'package:scoops/core/data/models/establishment.dart';

import 'package:scoops/ui/widgets/common/pileWidget.dart';
import 'package:scoops/ui/widgets/common/ratingWidget.dart';

class EstablishmentCard extends StatelessWidget {
  const EstablishmentCard({Key key, this.establishment, this.tag})
      : super(key: key);
  final Establishment establishment;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  establishment.imageUrl,
                  fit: BoxFit.fitHeight,
                  width: 310,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        tag,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          establishment.name,
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Rating(
                        rating: establishment.rating.overallRating,
                        reviews: establishment.rating.ratings,
                      ),
                      Container(
                          height: 20,
                          child: VerticalDivider(
                            color: Colors.black,
                            indent: 2,
                            endIndent: 2,
                          )),
                      Text(
                        establishment.establishmentType,
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      child: Row(children: [
                        Pill(
                            text: 'Live Music',
                            icon: Icons.music_note_rounded,
                            backgroundColor:
                                new Color(0xffB4CBF2).withOpacity(0.7),
                            textColor: new Color(0xff4C95FF)),
                      ]))
                ],
              ),
            ),
          ],
        ));
  }
}
