import 'package:campuscravings/src/models/product_item_detail_model.dart';
import 'package:campuscravings/src/src.dart';

final cartItemsProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(CartItem item) {
    final index = state.indexWhere((e) => e.id == item.id);

    // if (index >= 0) {
    //   final existingItem = state[index];
    //   final newQuantity = (existingItem.quantity + item.quantity).clamp(1, 10);
    //   final updatedItem = existingItem.copyWith(quantity: newQuantity);
    //   state = [...state]..[index] = updatedItem;
    // } else {
    final newQuantity = item.quantity.clamp(1, 10);
    state = [...state, item.copyWith(quantity: newQuantity)];
    // }
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
    final updatedItem = state[index].copyWith(
      quantity: state[index].quantity + 1,
    );
    state = [...state]..[index] = updatedItem;
  }

  void decrementQuantity(int index) {
    final currentQuantity = state[index].quantity;
    if (currentQuantity > 1) {
      final updatedItem = state[index].copyWith(quantity: currentQuantity - 1);
      state = [...state]..[index] = updatedItem;
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
