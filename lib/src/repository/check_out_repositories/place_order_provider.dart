import 'package:campuscravings/src/src.dart';

final demandRepositoryProvider = Provider<PlaceOrderRepository>((ref) {
  return PlaceOrderRepository();
});

final demandMultiplierProvider = FutureProvider<double>((ref) async {
  final demandRepository = ref.watch(demandRepositoryProvider);
  return await demandRepository.fetchDemandMultiplierOnly();
});

