import 'package:campuscravings/src/models/product_item_detail_model.dart';
import 'package:campuscravings/src/repository/home_repository/product_catalog_repository.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final ProductRepository _productRepository;
  ProductDetailsController(this._productRepository);
  late String _productId;
  String get productId => _productId;
  ProductItemDetailModel? _productItemDetailModel;
  ProductItemDetailModel? get productItemDetailModel => _productItemDetailModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int _productQuantity = 1;
  int get productQuantity => _productQuantity;
  String selectedSizeId = '';

  void setProductId(String productId) {
    _productId = productId;
    _productQuantity = 1;
  }

  Future<void> getProductDetails() async {
    try {
      _isLoading = true;
      update();

      _productItemDetailModel = await _productRepository.getProductItemDetails(
        itemId: _productId,
      );

      final item = _productItemDetailModel!;
      selectedCustomizations = [];
      // Reset size price and id to defaults
      selectedSizePrice = 0.0;
      selectedSizeId = item.sizes.first.id ?? "";

      // Auto-select smallest size only if base price is 0 and sizes exist
      if (item.price == 0 && item.sizes.isNotEmpty) {
        item.sizes.sort((a, b) => a.price.compareTo(b.price));
        final smallestSize = item.sizes.first;

        selectedSizePrice = smallestSize.price;
        selectedSizeId = smallestSize.id;
      }

      getTotalPrice();
      _isLoading = false;
      update();
    } catch (e) {
      _isLoading = false;
      update();
    }
  }

  double totalPrice = 0.00;
  List<CustomizationModel> selectedCustomizations = [];
  double selectedSizePrice = 0.0;

  void incrementProductQuantity() {
    _productQuantity++;
    getTotalPrice();
  }

  void decrementProductQuantity() {
    if (_productQuantity > 1) {
      _productQuantity--;
      getTotalPrice();
    }
  }

  void getTotalPrice() {
    double basePrice = _productItemDetailModel?.price ?? 0.0;

    double customizationsPrice =
        selectedCustomizations.isNotEmpty
            ? selectedCustomizations
                .map((i) => i.price)
                .fold(0.0, (a, b) => a + b)
            : 0.0;

    double totalSingleItemPrice =
        basePrice + selectedSizePrice + customizationsPrice;

    totalPrice = totalSingleItemPrice * _productQuantity;

    update();
  }
}
