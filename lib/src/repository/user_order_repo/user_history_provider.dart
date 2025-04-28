import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/models/Rider_History_Model/rider_history.dart';

// Instantiate the repo
final userHistoryRepoProvider = Provider<UserhistoryRepository>((ref) {
  return UserhistoryRepository();
});

// Fetch orders
final userHistoryProvider = FutureProvider<RiderHistory>((ref) async {
  final repo = ref.watch(userHistoryRepoProvider);
  return repo.fetchUserHistory();
});
