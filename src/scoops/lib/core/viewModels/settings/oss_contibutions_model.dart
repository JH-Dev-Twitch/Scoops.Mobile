import 'dart:async';

import 'package:scoops/core/data/models/oss_contribution.dart';
import 'package:scoops/core/enums/view_state.dart';
import 'package:scoops/core/infrastructure/app_locator.dart';
import 'package:scoops/core/services/oss_contributions_service.dart';
import 'package:scoops/core/viewModels/base_model.dart';
import 'package:url_launcher/url_launcher.dart';

class OSSContributionsModel extends BaseModel {
  final _ossService = locator<OSSContributionsService>();
  final StreamController _contributionsController =
      StreamController<List<OSSContribution>>();

  Stream<List<OSSContribution>> get contributionsStream =>
      _contributionsController.stream;

  Future loadPageAsync() async {
    setState(ViewState.Loading);
    var contributions = await _ossService.loadContributionsAsync();
    _contributionsController.sink.add(contributions);
    setState(ViewState.Ready);
  }

  void dispose() {
    _contributionsController.close();
    super.dispose();
  }

  Future openLink(String link) async => await launch(link);
}
