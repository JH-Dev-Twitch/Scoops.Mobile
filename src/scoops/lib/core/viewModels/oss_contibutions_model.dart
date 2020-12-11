import 'package:scoops/core/data/models/oss_contribution.dart';
import 'package:scoops/core/viewModels/base_model.dart';
import 'package:url_launcher/url_launcher.dart';

class OSSContributionsModel extends BaseModel {
  List<OSSContribution> contributions = [
    OSSContribution(
        id: "sjkfghjkdfghkjdfhg",
        name: "Beverage Animation",
        owner: "Joris van Raaij",
        type: "Animation",
        description: "The main animation which greets the user",
        link: "https://lottiefiles.com/77-im-thirsty"),
    OSSContribution(
        id: "dsfjslfjksdlf",
        name: "flutter_appcenter_bundle",
        owner: "Alois Daniel",
        type: "Library",
        description: "Used for testing and crashes",
        link: "https://github.com/aloisdeniel/flutter_plugin_appcenter")
  ];

  Future openLink(String link) async => await launch(link);
}
