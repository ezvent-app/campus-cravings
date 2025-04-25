import 'package:campuscravings/src/src.dart';

class PlaceOrderRepository {
  final HttpAPIServices _services = HttpAPIServices();

  //CREATE ORDER API

  placeOrderMethod(Map<String, dynamic> json, BuildContext context) async {
    final res = await _services.postAPI(url: '/admin/order', map: json);
    final body = jsonDecode(res.body);
    if (res.statusCode == 200 || res.statusCode == 201) {
      printThis("Order created ${res.body}");
      if (context.mounted) {
        context.pushRoute(const CheckoutAddressRoute());
      }
    } else {
      if (context.mounted) {
        showToast(body['message'], context: context);
      }
    }
  }
}
