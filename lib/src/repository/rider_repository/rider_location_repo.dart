import 'dart:developer';

import 'package:campuscravings/src/src.dart';

class RiderLocationRepo {
  HttpAPIServices services = HttpAPIServices();

  sendLocation(Map<String, dynamic> json) async {
    final res = await services.patchAPI(url: '/rider/location', map: json);
    if (res.statusCode == 201 || res.statusCode == 200) {
      log("Rider Location sent ${res.body}");
    }
  }
}
