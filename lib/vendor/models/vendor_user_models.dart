class VendorUserModel {
  final bool? approved;
  final String? vendorId;
  final String? bussinessName;
  final String? cityValue;
  final String? countryValue;
  final String? email;
  final String? phoneNumber;
  final String? stateValue;
  final String? storeImage;
  final String? taxNumber;
  final String? taxRegistered;

  VendorUserModel({
    this.approved,
    this.vendorId,
    this.bussinessName,
    this.cityValue,
    this.countryValue,
    this.email,
    this.phoneNumber,
    this.stateValue,
    this.storeImage,
    this.taxNumber,
    this.taxRegistered,
  });

  factory VendorUserModel.fromJson(Map<String, dynamic> json) {
    return VendorUserModel(
      approved: json['approved'] as bool? ?? false,
      vendorId: json['vendorId'] as String? ?? '',
      bussinessName: json['bussinessName'] as String? ?? '',
      cityValue: json['cityValue'] as String? ?? '',
      countryValue: json['countryValue'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      stateValue: json['stateValue'] as String? ?? '',
      storeImage: json['storeImage'] as String? ?? '',
      taxNumber: json['taxNumber'] as String? ?? '',
      taxRegistered: json['taxRegistered'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'approved': approved,
      'vendorId': vendorId,
      'bussinessName': bussinessName,
      'cityValue': cityValue,
      'countryValue': countryValue,
      'email': email,
      'phoneNumber': phoneNumber,
      'stateValue': stateValue,
      'storeImage': storeImage,
      'taxNumber': taxNumber,
      'taxRegistered': taxRegistered,
    };
  }
}
