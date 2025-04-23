import 'package:campuscravings/src/controllers/home_controller.dart';
import 'package:campuscravings/src/repository/home_repository/home_repository.dart';
import 'package:campuscravings/src/services/http_api_services.dart';
import 'package:campuscravings/src/services/location_service.dart';
import 'package:get/get.dart';

class DependencyInjection {

  static void initialize(){
    Get.lazyPut<HttpApiServices>(() => HttpApiServices());
    Get.lazyPut<HomeRepository>(() => HomeRepository(Get.find<HttpApiServices>()));
    Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<HomeController>(() => HomeController(Get.find<LocationService>(),Get.find<HomeRepository>()),fenix: true);
  }
  // static final DependencyInjection _instance = DependencyInjection._internal();
  //
  // factory DependencyInjection() {
  //   return _instance;
  // }
  //
  // DependencyInjection._internal();
  //
  // // Add your dependencies here
  // // Example:
  // // final SomeService someService = SomeService();
}