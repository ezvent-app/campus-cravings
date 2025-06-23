import 'package:campuscravings/src/repository/user_info_repo/user_info_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:campuscravings/src/models/User Model/user_info_model.dart';

// Provider for UserController
final userControllerProvider =
    StateNotifierProvider<UserController, UserModel?>((ref) {
      return UserController(ref);
    });

// Provider for UserInfoRepository
final userInfoRepositoryProvider = Provider<UserInfoRepository>((ref) {
  return UserInfoRepository();
});

class UserController extends StateNotifier<UserModel?> {
  final Ref ref;
  UserController(this.ref) : super(null) {
    _initialize();
  }
  Future<void> refreshUser() async {
    state = null;
    await fetchUser();
  }

  Future<void> _initialize() async {
    if (state == null) {
      await fetchUser();
    }
  }

  Future<void> fetchUser() async {
    try {
      final user =
          await ref.read(userInfoRepositoryProvider).fetchUserProfile();
      state = user;
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  UserModel get user {
    if (state == null) {
      throw Exception('User not initialized. Call fetchUser() first');
    }
    return state!;
  }

  void updateBasicInfo({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? imgUrl,
    String? email,
  }) {
    if (state == null) return;

    final currentUser = state!;
    final currentInfo = currentUser.userInfo!;

    final newInfo = UserInfo(
      sId: currentInfo.sId,
      firstName: firstName ?? currentInfo.firstName,
      lastName: lastName ?? currentInfo.lastName,
      phoneNumber: phoneNumber ?? currentInfo.phoneNumber,
      email: email ?? currentInfo.email,
      imgUrl: imgUrl ?? currentInfo.imgUrl,
      fullName: currentInfo.fullName,
      userName: currentInfo.userName,
      authMethod: currentInfo.authMethod,
      addresses: currentInfo.addresses,
      status: currentInfo.status,
      isRestaurant: currentInfo.isRestaurant,
      isDelivery: currentInfo.isDelivery,
      isCustomer: currentInfo.isCustomer,
      isAdmin: currentInfo.isAdmin,
      isEmailVerified: currentInfo.isEmailVerified,
      isPhoneVerified: currentInfo.isPhoneVerified,
      isProfileCompleted: currentInfo.isProfileCompleted,
      lastAccess: currentInfo.lastAccess,
      notificationCount: currentInfo.notificationCount,
      planPro: currentInfo.planPro,
      iV: currentInfo.iV,
    );

    state = UserModel(message: currentUser.message, userInfo: newInfo);
  }

  void updateAddress(List<Addresses> newAddresses) {
    if (state == null) return;

    final currentUser = state!;
    final currentInfo = currentUser.userInfo!;

    final newInfo = UserInfo(
      sId: currentInfo.sId,
      firstName: currentInfo.firstName,
      lastName: currentInfo.lastName,
      phoneNumber: currentInfo.phoneNumber,
      email: currentInfo.email,
      fullName: currentInfo.fullName,
      userName: currentInfo.userName,
      authMethod: currentInfo.authMethod,
      addresses: newAddresses,
      status: currentInfo.status,
      isRestaurant: currentInfo.isRestaurant,
      isDelivery: currentInfo.isDelivery,
      isCustomer: currentInfo.isCustomer,
      isAdmin: currentInfo.isAdmin,
      isEmailVerified: currentInfo.isEmailVerified,
      isPhoneVerified: currentInfo.isPhoneVerified,
      isProfileCompleted: currentInfo.isProfileCompleted,
      lastAccess: currentInfo.lastAccess,
      notificationCount: currentInfo.notificationCount,
      planPro: currentInfo.planPro,
      iV: currentInfo.iV,
      imgUrl: currentInfo.imgUrl,
    );

    state = UserModel(message: currentUser.message, userInfo: newInfo);
  }

  void updateProfileImage(String newImageUrl) {
    if (state == null) return;

    final currentUser = state!;
    final currentInfo = currentUser.userInfo!;

    final newInfo = UserInfo(
      sId: currentInfo.sId,
      firstName: currentInfo.firstName,
      lastName: currentInfo.lastName,
      phoneNumber: currentInfo.phoneNumber,
      email: currentInfo.email,
      fullName: currentInfo.fullName,
      userName: currentInfo.userName,
      authMethod: currentInfo.authMethod,
      addresses: currentInfo.addresses,
      status: currentInfo.status,
      isRestaurant: currentInfo.isRestaurant,
      isDelivery: currentInfo.isDelivery,
      isCustomer: currentInfo.isCustomer,
      isAdmin: currentInfo.isAdmin,
      isEmailVerified: currentInfo.isEmailVerified,
      isPhoneVerified: currentInfo.isPhoneVerified,
      isProfileCompleted: currentInfo.isProfileCompleted,
      lastAccess: currentInfo.lastAccess,
      notificationCount: currentInfo.notificationCount,
      planPro: currentInfo.planPro,
      iV: currentInfo.iV,
      imgUrl: newImageUrl,
    );

    state = UserModel(message: currentUser.message, userInfo: newInfo);
  }
}
