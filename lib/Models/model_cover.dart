class newCoverLetterModel {
  String title;
  String summary;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? address;

  newCoverLetterModel({
    required this.title,
    required this.summary,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.address,
  });
}
