import 'package:campuscravings/src/models/Rider_delivery_model/Rider_delivery_model.dart';
import 'package:campuscravings/src/repository/rider_delivery_repo/rider_delivery_repo.dart';
import 'package:campuscravings/src/src.dart';

// Instantiate the repo
final riderDeliveryRepoProvider = Provider<RiderDelvieryRepo>((ref) {
  return RiderDelvieryRepo();
});

// Fetch orders (no userId needed)
final riderDeliveryProvider = FutureProvider.family<RiderDeliveryModel, String>(
  (ref, orderId) async {
    final repo = ref.watch(riderDeliveryRepoProvider);
    return repo.orderAcceptedByRider(orderId, {"status": "order_dispatched"});
  },
);
