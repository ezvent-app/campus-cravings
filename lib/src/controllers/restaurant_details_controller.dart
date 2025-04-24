import 'package:campuscravings/src/repository/home_repository/restaurant_repository.dart';
import 'package:get/get.dart';

class RestaurantDetailsController extends GetxController{

  final RestaurantRepository _restaurantRepository;
  RestaurantDetailsController(this._restaurantRepository);
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _restaurantId = '';
  String get restaurantId => _restaurantId;

  void setRestaurantId(String restaurantId){
    _restaurantId = restaurantId;
  }

}