import 'package:campuscravings/src/constants/get_builder_id_constants.dart';
import 'package:campuscravings/src/controllers/location_controller.dart';
import 'package:campuscravings/src/models/product_item_model.dart';
import 'package:campuscravings/src/repository/home_repository/product_catalog_repository.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProductCatalogController extends GetxController {
  final ProductRepository _homeRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<ProductItemModel> _listOfPopularItems = [];
  List<ProductItemModel> get listOfPopularItems => _listOfPopularItems;
  ProductCatalogController(this._homeRepository);

  Future<void> getPopularItems() async {
    try {
      if (_listOfPopularItems.isNotEmpty) return;
      _isLoading = true;
      update([popularItemBuilderId]);
      while (Get.find<LocationController>().isOperationInProgress) {
        await Future.delayed(Duration(milliseconds: 500));
      }
      final location =
          await Get.find<LocationController>().getCurrentLocation();
      if (location == null) {
        _isLoading = false;
        update([popularItemBuilderId]);
        return;
      }
      _listOfPopularItems =
          (await _homeRepository.getPopularItems(
            lat: location.latitude,
            lng: location.longitude,
          )) ??
          [];
      _isLoading = false;
      update([popularItemBuilderId]);
      return;
      // Logger().i(data!.length);
    } catch (e) {
      Logger().i(e);
      _isLoading = false;
      update([popularItemBuilderId]);
    }
    return;
  }
}
