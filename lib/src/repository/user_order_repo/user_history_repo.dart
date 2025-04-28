import 'dart:async';

import 'package:campuscravings/src/models/Rider_History_Model/rider_history.dart';
import 'package:campuscravings/src/src.dart';

class UserhistoryRepository {
  final HttpAPIServices services = HttpAPIServices();

  Future<RiderHistory> fetchUserHistory() async {
    try {
      final response = await services.getAPI('/user/orders/');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return RiderHistory.fromJson(data);
      } else {
        return Future.error(
          'Failed to load data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is TimeoutException) {
        return Future.error('Request timed out. Please try again.');
      } else {
        print(e.toString());
        return Future.error('Something went wrong');
      }
    }
  }
}
