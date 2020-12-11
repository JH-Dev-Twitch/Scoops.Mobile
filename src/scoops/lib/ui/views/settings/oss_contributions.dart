import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoops/core/data/models/oss_contribution.dart';
import 'package:scoops/core/viewModels/oss_contibutions_model.dart';
import 'package:scoops/ui/styling/custom_icons_icons.dart';
import 'package:scoops/ui/views/base_view.dart';
import 'package:scoops/ui/widgets/common/icon_tile.dart';
import 'package:scoops/ui/widgets/common/plain_app_bar.dart';

class OSSContributionsView extends StatelessWidget {
  OSSContributionsView({Key key}) : super(key: key);

  Widget buildContributionIcon(String type) => IconTile(
        type == "Library" ? CustomIcons.github_circled : Icons.image_rounded,
        type == "Library" ? Colors.black : Colors.blue,
        Colors.white,
        iconSize: 18,
      );
  @override
  Widget build(BuildContext context) {
    return BaseView<OSSContributionsModel>(
        onDispose: (model) => model.dispose(),
        onModelReady: (model) async => await model.loadPageAsync(),
        builder: (context, model, child) => Scaffold(
            appBar: child,
            body: SafeArea(
                child: StreamBuilder(
                    stream: model.contributionsStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var contributions =
                            snapshot.data as List<OSSContribution>;
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            var contribution = contributions[index];
                            return GestureDetector(
                              onTap: () async =>
                                  await model.openLink(contribution.link),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: buildContributionIcon(
                                        contribution.type),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        contribution.name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(contribution.owner),
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(Icons.chevron_right_rounded)
                                ]),
                              ),
                            );
                          },
                          itemCount: contributions.length,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }))),
        child: PlainAppBar.buildAppBar(context, title: "OSS Contributions"));
  }
}
