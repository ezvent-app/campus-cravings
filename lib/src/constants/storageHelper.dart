import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static const String _userId = "_id";
  static const String _riderId = "_riderId";
  static const String _paymentUrl = "_url";
  static const String resCords = "coords";
  static const String _riderOrderId = "item_id";
  static const String _accessToken = "accessToken";
  static const String _isProfileComple = "isProfileComplet";
  static const String _isRiderProfileComple = "isRiderProfileComple";
  static final StorageHelper _singleton = StorageHelper._internal();
  StorageHelper._internal();

  static Future init() async {
    var result = await GetStorage.init();
    print("GetStorageIsIntilized$result");
  }

  factory StorageHelper() {
    return _singleton;
  }

  GetStorage prefs = GetStorage();
  GetStorage tempBox = GetStorage('TempData');

  _savePref(String key, Object? value) async {
    // var prefs = GetStorage();
    prefs.write(key, value);
  }

  T _getPref<T>(String key) {
    return prefs.read(key) as T;
  }

  void clear() {
    prefs.erase();
    tempBox.erase();
    GetStorage().erase();
    GetStorage('TempData').erase();

    print("✅ All persistent storage cleared successfully on logout.");
  }

  //create a methods to save the data below
  void saveUserId(String? id) {
    _savePref(_userId, id);
  }

  void saveCustomerCoords(List<double> coords) {
    _savePref(resCords, coords);
  }

  List<double>? getCustomerCoords() {
    return _getPref(resCords);
  }

  String? getUserId() {
    return _getPref(_userId);
  }

  String? getRiderId() {
    return _getPref(_riderId);
  }

  void saveRiderId(String? id) {
    _savePref(_riderId, id);
  }

  String? getPyemntGenUrl() {
    return _getPref(_paymentUrl);
  }

  void savePaymentGenUrl(String? url) {
    _savePref(_paymentUrl, url);
  }

  void saveRiderOrderId(String? id) {
    _savePref(_riderOrderId, id);
  }

  String? getRiderOrderId() {
    return _getPref(_riderOrderId);
  }

  void saveAccessToken(String? id) {
    _savePref(_accessToken, id);
  }

  String? getAccessToken() {
    return _getPref(_accessToken);
  }

  void saveIsProfilefileComplete(bool value) {
    _savePref(_isProfileComple, value);
  }

  void saveRiderProfileComplete(bool value) {
    _savePref(_isRiderProfileComple, value);
  }

  bool getRiderProfilefileComplete() {
    return _getPref(_isRiderProfileComple) ?? false;
  }

  bool getIsProfilefileComplete() {
    return _getPref(_isProfileComple) ?? false;
  }
}
