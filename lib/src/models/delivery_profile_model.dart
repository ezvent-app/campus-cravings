class DeliveryProfileModel {
  String socialSecurityNumber;
  bool isAgree;
  String nICImage;

  DeliveryProfileModel(
      {required this.socialSecurityNumber,
      required this.isAgree,
      required this.nICImage});

  DeliveryProfileModel copyWith(
      {String? socialSecurityNumber, bool? isAgree, String? nICImage}) {
    return DeliveryProfileModel(
        socialSecurityNumber: socialSecurityNumber ?? this.socialSecurityNumber,
        isAgree: isAgree ?? this.isAgree,
        nICImage: nICImage ?? this.nICImage);
  }
}
