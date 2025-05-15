import 'dart:convert';
import 'package:campuscravings/src/models/Rider_delivery_model/rider_regsitarion_model.dart';
import 'package:campuscravings/src/services/http_api_services.dart';
import 'package:campuscravings/src/src.dart';
import 'package:logger/logger.dart';

class RiderRegsRepo {
  final HttpAPIServices services = HttpAPIServices();
  final Logger _logger = Logger();

  Future<RiderStatusResponse> riderRegStatusMethod(
    String id,
    BuildContext context,
  ) async {
    try {
      final response = await services.getAPI(
        '/rider/getRiderDetailByUserId//$id',
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final statusResponse = RiderStatusResponse.fromJson(json);

        _logger.i("Rider Status: ${statusResponse.data.status}");
        return statusResponse;
      } else if (response.statusCode == 404) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StudentProfileDetailsPage(),
          ),
        );
      } else {
        _logger.e("${response.statusCode} - ${response.body}");
        throw Exception('Failed to fetch rider status');
      }
    } catch (e) {
      _logger.e('Error fetching rider status: $e');
      throw Exception('Error fetching rider status');
    }
    throw Exception('Unexpected error occurred in riderRegStatusMethod');
  }
}
