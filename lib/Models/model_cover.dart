class CoverLetterModel {
  String title;
  String summary;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? address;
  double? fullness;

  CoverLetterModel({
    required this.title,
    required this.summary,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.address,
  });
}
