import 'dart:convert';

import 'package:campuscravings/src/models/Rider_delivery_model/Rider_delivery_model.dart';
import 'package:campuscravings/src/services/http_api_services.dart';
import 'package:logger/logger.dart';

class RiderDelvieryRepo {
  final HttpAPIServices services = HttpAPIServices();

  Future<RiderDeliveryModel> orderAcceptedByRider(
    String orderId,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await services.patchAPI(
        url: '/rider/acceptOrder',
        map: body,
      );
      if (response.statusCode == 200) {
        Logger().i("Order Accepted Successfully");
        final data = jsonDecode(response.body);

        return RiderDeliveryModel.fromJson(data);
      } else {
        Logger().i("${response.statusCode} - ${response.body}");
        throw Exception('Failed to accept order');
      }
    } catch (e) {
      Logger().e('Error accepting order: $e');
      throw Exception('Error accepting order: $e');
    }
  }
}
