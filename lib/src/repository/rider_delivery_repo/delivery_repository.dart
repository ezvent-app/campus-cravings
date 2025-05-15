import 'dart:convert';

import 'package:campuscravings/src/models/Rider_delivery_model/Rider_delivery_model.dart';
import 'package:campuscravings/src/repository/rider_delivery_repo/deliverd_model_bt_rider.dart';
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
        throw Exception('Failed');
      }
    } catch (e) {
      Logger().e('Error:');
      throw Exception('Error');
    }
  }

  Future<DeliveryStatusResponse> orderDeliverByRider(
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await services.patchAPI(
        url: '/rider/deliverOrder',
        map: body,
      );

      if (response.statusCode == 200) {
        Logger().i("Order Delivered Successfully!");
        final Map<String, dynamic> data = jsonDecode(response.body);
        return DeliveryStatusResponse.fromJson(data);
      } else {
        Logger().e(
          "Failed to deliver order: ${response.statusCode} - ${response.body}",
        );
        throw Exception('Failed to deliver order');
      }
    } catch (e, stack) {
      Logger().e('Error in orderDeliverByRider: $e');
      throw Exception('Error in delivering order');
    }
  }

  //rider accepting order during socket time
  Future<RiderDeliveryModel?> acceptedByRider(Map<String, dynamic> body) async {
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
      return null;
    }
  }
}
