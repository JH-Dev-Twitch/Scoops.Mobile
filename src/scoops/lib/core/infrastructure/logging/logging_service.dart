import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';

class LoggingService {
  Future trackEventAsync(String event) async =>
      await AppCenter.trackEventAsync(event);
}
