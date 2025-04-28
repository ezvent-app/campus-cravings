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
      _isLoading = false;
      update();
      return;
    } catch (e) {
      _isLoading = false;
      update();
      return;
    }
  }

  void incrementProductQuantity() {
    _productQuantity++;
    update();
  }

  void decrementProductQuantity() {
    if (_productQuantity > 1) {
      _productQuantity--;
      update();
    }
  }

  double getTotalPrice({
    double sizePrice = 0.0, // Default value if no size price is provided
    List<CustomizationModel> customizations =
        const [], // Default empty list if no customizations
  }) {
    // Check if the product details are available
    if (_productItemDetailModel == null) return 0.0;

    // Default base price (from the product details)
    double basePrice = _productItemDetailModel!.price;

    // Default quantity (assuming it's assigned somewhere else in your logic)
    int quantity = _productQuantity;

    // Calculate total customizations price using customizations from cartItemsNotifier
    double customizationsPrice =
        customizations.isNotEmpty
            ? customizations.map((i) => i.price).fold(0.0, (a, b) => a + b)
            : 0.0;

    // Final price per item (base price + size price + customization price)
    double totalSingleItemPrice = basePrice + sizePrice + customizationsPrice;

    // Multiply by quantity
    return totalSingleItemPrice * quantity;
  }
}
