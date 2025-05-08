import 'package:campuscravings/src/constants/storageHelper.dart';
import 'package:campuscravings/src/src.dart';
import 'package:logger/logger.dart';

class RiderPayoutRepo {
  final HttpAPIServices services = HttpAPIServices();
  final Logger _logger = Logger();

  Future<dynamic> generateOnboardingLink(
    String id,
    String successUrl,
    String failureUrl,

    BuildContext context,
  ) async {
    try {
      final response = await services.getAPI(
        '/payments/onboard/$id?successUrl=$successUrl&failureUrl=$failureUrl',
      );

      if (response.statusCode == 200) {
        _logger.i("Link Generated Successfully!");
        final data = jsonDecode(response.body);
        final link = data['data']['url'];
        await context.router.replaceAll([AddPayoutRoute(url: link)]);
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

  Future<dynamic> changeUserStatus(String id) async {
    try {
      final response = await services.getAPI(
        '/restaurants/changeRestaurantStatus/$id',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _logger.i("Status Changed Successfully!");
        final data = jsonDecode(response.body);
        return data;
      } else {
        _logger.i("${response.statusCode} - ${response.body}");
        throw Exception('Failed to Changed status');
      }
    } catch (e) {
      _logger.e('Error while changin status: $e');
      return null;
    }
  }
}
