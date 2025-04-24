import 'package:campuscravings/src/src.dart';
import 'package:campuscravings/src/models/Rider_History_Model/rider_history.dart';

// Instantiate the repo
final historyRepoProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository();
});

// Fetch orders (no userId needed)
final riderHistoryProvider = FutureProvider<RiderHistory>((ref) async {
  final repo = ref.watch(historyRepoProvider);
  return repo.fetchUserHistory();
});
