import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/models/Rider_History_Model/rider_history.dart';

// Instantiate the repo
final historyRepoProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository();
});

// Fetch orders for a specific user
final riderHistoryProvider = FutureProvider.family<RiderHistory, String>((
  ref,
  userId,
) async {
  final repo = ref.watch(historyRepoProvider);
  return repo.fetchUserHistory(userId);
});
