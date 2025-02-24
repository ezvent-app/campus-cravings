import 'package:campus_cravings/src/src.dart';

final deliveryProfileProvider =
    StateNotifierProvider<DeliveryProfileProvider, DeliveryProfileModel>(
        (ref) => DeliveryProfileProvider());

class DeliveryProfileProvider extends StateNotifier<DeliveryProfileModel> {
  DeliveryProfileProvider()
      : super(DeliveryProfileModel(
            socialSecurityNumber: '', isAgree: false, nICImage: ''));

  void updateSocialSecurityNumber(String value) => state =
      state.copyWith(socialSecurityNumber: state.socialSecurityNumber = value);

  void updateNICImage(String value) =>
      state = state.copyWith(nICImage: state.nICImage = value);

  void updateTermsAndConditions(bool value) =>
      state = state.copyWith(isAgree: state.isAgree = value);
}
