import 'package:hive/hive.dart';

class CoverLetterModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String summary;

  @HiveField(2)
  String? firstName;

  @HiveField(3)
  String? lastName;

  @HiveField(4)
  String? phoneNumber;

  @HiveField(5)
  String? email;

  @HiveField(6)
  String? address;

  @HiveField(7)
  double? fullness;

  CoverLetterModel({
    required this.title,
    required this.summary,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.address,
    required this.fullness
  });
}
