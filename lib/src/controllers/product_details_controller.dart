import 'package:campuscravings/src/models/product_item_detail_model.dart';
import 'package:campuscravings/src/repository/home_repository/product_catalog_repository.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController{

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

  void setProductId(String productId){
    _productId = productId;
    _productQuantity = 1;
  }

  Future<void> getProductDetails() async{
    try{
      _isLoading = true;
      update();
      _productItemDetailModel = await _productRepository.getProductItemDetails(itemId: _productId);
      _isLoading = false;
      update();
      return;
    }catch(e){
      _isLoading = false;
      update();
      return;
    }
  }
  void incrementProductQuantity(){
    _productQuantity++;
    update();
  }
  void decrementProductQuantity(){
    if(_productQuantity > 1){
      _productQuantity--;
      update();
    }
  }
  double getTotalPrice(){
    if(_productItemDetailModel == null) return 0.0;
    return _productItemDetailModel!.price * _productQuantity;
  }
}