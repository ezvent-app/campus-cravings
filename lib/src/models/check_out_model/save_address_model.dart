class SaveAddressModel {
  final String fullAddress;
  final String addressType;
  final bool isDefault;

  SaveAddressModel({
    required this.fullAddress,
    required this.addressType,
    required this.isDefault,
  });
}

List<SaveAddressModel> saveNewAddress = [];
