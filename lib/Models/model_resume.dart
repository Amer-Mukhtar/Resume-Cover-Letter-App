import 'dart:io';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ResumeModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String job;

  @HiveField(2)
  Uint8List? profile_image;

  @HiveField(3)
  Intro? intro;

  @HiveField(4)
  double? fullness;

  @HiveField(5)
  Contact? contact;

  @HiveField(6)
  List<Education> education;

  @HiveField(7)
  List<Experience> experience;

  @HiveField(8)
  List<Description> descriptions;

  @HiveField(9)
  List<Skill> skills;

  @HiveField(10)
  List<Language> languages;

  @HiveField(11)
  List<Certification> certifications;

  @HiveField(12)
  List<Reference> refrences;

  @HiveField(13)
  File? resume;

  @HiveField(14)
  Uint8List? resume_snapshot;

  @HiveField(15)
  List<Achievements> achievements;

  ResumeModel({
    required this.title,
    required this.job,
    this.profile_image,
    this.resume_snapshot,
    this.resume,
    this.intro,
    this.fullness,
    this.contact,
    this.education = const [],
    this.experience = const [],
    this.descriptions = const [],
    this.skills = const [],
    this.languages = const [],
    this.certifications = const [],
    this.refrences = const [],
    this.achievements=const [],
  });
}


@HiveType(typeId: 1)
class Intro extends HiveObject {
  @HiveField(0)
  String firstName;

  @HiveField(1)
  String lastName;

  @HiveField(2)
  String summary;

  Intro({
    required this.firstName,
    required this.lastName,
    required this.summary,
  });
}

@HiveType(typeId: 2)
class Contact extends HiveObject {
  @HiveField(0)
  String email;

  @HiveField(1)
  String phoneNumber;

  @HiveField(2)
  String website;

  @HiveField(3)
  String address;

  Contact({
    required this.email,
    required this.phoneNumber,
    required this.website,
    required this.address,
  });
}

@HiveType(typeId: 3)
class Education extends HiveObject {
  @HiveField(0)
  String schoolTitle;

  @HiveField(1)
  String major;

  @HiveField(2)
  String from;

  @HiveField(3)
  String to;

  Education({
    required this.schoolTitle,
    required this.major,
    required this.from,
    required this.to,
  });
}

@HiveType(typeId: 4)
class Experience extends HiveObject {
  @HiveField(0)
  String company;

  @HiveField(1)
  String position;

  @HiveField(2)
  String location;

  @HiveField(3)
  String from;

  @HiveField(4)
  String to;

  @HiveField(5)
  String description;

  Experience({
    required this.company,
    required this.position,
    required this.location,
    required this.from,
    required this.to,
    required this.description,
  });
}

@HiveType(typeId: 5)
class Description extends HiveObject {
  @HiveField(0)
  String certificationTitle;

  Description({
    required this.certificationTitle,
  });
}

@HiveType(typeId: 6)
class Skill extends HiveObject {
  @HiveField(0)
  String skillName;

  @HiveField(1)
  double level;

  Skill({
    required this.skillName,
    required this.level,
  });
}

@HiveType(typeId: 7)
class Language extends HiveObject {
  @HiveField(0)
  String language;

  @HiveField(1)
  String level;

  Language({
    required this.language,
    required this.level,
  });
}

@HiveType(typeId: 8)
class Certification extends HiveObject {
  @HiveField(0)
  String certificationName;

  Certification({
    required this.certificationName,
  });
}

@HiveType(typeId: 9)
class Reference extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String company;

  @HiveField(2)
  String position;

  @HiveField(3)
  String phone;

  @HiveField(4)
  String email;

  Reference({
    required this.name,
    required this.position,
    required this.company,
    required this.email,
    required this.phone,
  });

}
@HiveType(typeId: 10)
class Achievements {
  @HiveField(0)
  String name;

  @HiveField(1)
  String Descirption;

  Achievements({
    required this.name,
    required this.Descirption,

  });
}

