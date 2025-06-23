import 'package:campuscravings/src/models/product_item_detail_model.dart';
import 'package:campuscravings/src/src.dart';

final cartItemsProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);
  bool _isSameCustomization(
    List<CustomizationModel> a,
    List<CustomizationModel> b,
  ) {
    if (a.length != b.length) return false;

    final sortedA = [...a]..sort((x, y) => x.id.compareTo(y.id));
    final sortedB = [...b]..sort((x, y) => x.id.compareTo(y.id));

    for (int i = 0; i < sortedA.length; i++) {
      if (sortedA[i].id != sortedB[i].id) return false;
    }

    return true;
  }

  bool addItem(CartItem newItem) {
    final index = state.indexWhere(
      (item) =>
          item.id == newItem.id &&
          item.size == newItem.size &&
          _isSameCustomization(item.customization, newItem.customization),
    );

    if (index != -1) {
      final existingItem = state[index];
      final newQuantity = (existingItem.quantity + newItem.quantity).clamp(
        1,
        10,
      );
      final updatedItem = existingItem.copyWith(quantity: newQuantity);
      state = [...state]..[index] = updatedItem;
      return false;
    } else {
      final newQuantity = newItem.quantity.clamp(1, 10);
      state = [...state, newItem.copyWith(quantity: newQuantity)];
      return true;
    }
  }

  void removeItem(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  void clearCart() {
    state = [];
  }

  double get total =>
      state.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void incrementQuantity(int index) {
    final item = state[index];
    final newQuantity = (item.quantity + 1).clamp(1, 10);
    final updatedItem = item.copyWith(quantity: newQuantity);
    state = [...state]..[index] = updatedItem;
  }

  void decrementQuantity(int index) {
    final item = state[index];
    if (item.quantity > 1) {
      final updatedItem = item.copyWith(quantity: item.quantity - 1);
      state = [...state]..[index] = updatedItem;
    } else {
      state = List.from(state)..removeAt(index);
    }
  }

  String selectedSizeId = '';
  double selectedSizePrice = 0.00;
  void selectSize(int index, String sizeID, double sizePrice) {
    selectedSizeId = sizeID;
    selectedSizePrice = sizePrice;

    printThis("✅ Size updated to $sizeID at index $index price $sizePrice");
    printThis("👉 Selected sizeId after tap: $selectedSizeId");
  }

  List<CustomizationModel> selectedCustomizations = [];

  void updateCustomization(int index, List<CustomizationModel> customizations) {
    if (index >= 0 && index < state.length) {
      final updatedItem = state[index].copyWith(customization: customizations);
      state = [...state]..[index] = updatedItem;
      print("✅ Customizations updated at index $index");
    } else {
      print(
        "❌ Invalid index for updateCustomization: $index (List length: ${state.length})",
      );
    }
  }
}
