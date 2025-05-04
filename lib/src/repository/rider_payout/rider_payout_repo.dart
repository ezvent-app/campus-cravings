import 'dart:convert';

import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/services/services.dart';
import 'package:logger/logger.dart';

class RiderPayoutRepo {
  final HttpAPIServices services = HttpAPIServices();
  final Logger _logger = Logger();

  Future<dynamic> generateOnboardingLink(String id) async {
    try {
      final response = await services.getAPI('/payments/onboard/$id');

      if (response.statusCode == 200) {
        _logger.i("Link Generated Successfully!");
        final data = jsonDecode(response.body);
        final link = data['data']['url'];
        _logger.i("Here is your Link: $link");
        StorageHelper().savePaymentGenUrl(link);
        return data;
      } else {
        _logger.i("${response.statusCode} - ${response.body}");
        throw Exception('Failed to generate onboarding link');
      }
    } catch (e) {
      _logger.e('Error while generating link: $e');
      return null;
    }
  }
}
