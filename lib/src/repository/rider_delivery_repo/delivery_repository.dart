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
        url: '/admin/order/$orderId',
        map: body,
      );
      if (response.statusCode == 200) {
        Logger().i("Order Accepted and in progress!");
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

  //rider accepting order during socket time
  Future<RiderDeliveryModel> acceptedByRider(Map<String, dynamic> body) async {
    try {
      final response = await services.putAPI(
        url: '/rider/acceptOrder',
        map: body,
      );
      if (response.statusCode == 200) {
        Logger().i("Order Accepted Successfully by Rider");
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
