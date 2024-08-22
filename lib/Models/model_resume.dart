import 'dart:io';

class ResumeModel {
  String title;
  String job;
  File ?profile_image;
  Intro? intro;
  double? fullness;
  Contact? contact;
  List<Education> education;
  List<Experience> experience;
  List<Description> descriptions;
  List<Skill> skills;
  List<Language> languages;
  List<Certification> certifications;


  ResumeModel(
      {
    required this.title,
        required this.job,
       this.profile_image,
        this.fullness,
    this.intro,
    this.contact,
    List<Education>? education,
    List<Experience>? experience,
    List<Description>? descriptions,
    List<Skill>? skills,
    List<Language>? languages,
    List<Certification>? certifications,
  })  : education = education ?? [],
        experience = experience ?? [],
        descriptions = descriptions ?? [],
        skills = skills ?? [],
        languages = languages ?? [],
        certifications = certifications ?? [];
}

class Intro {
  String firstName;
  String lastName;
  String summary;

  Intro({
    required this.firstName,
    required this.lastName,
    required this.summary,
  });
}

class Contact {
  String email;
  String phoneNumber;
  String website;
  String address;

  Contact({
    required this.email,
    required this.phoneNumber,
    required this.website,
    required this.address,
  });
}

class Education {
  String schoolTitle;
  String major;
  String from;
  String to;

  Education({
    required this.schoolTitle,
    required this.major,
    required this.from,
    required this.to,
  });
}

class Experience {
  String company;
  String position;
  String location;
  String from;
  String to;
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

class Description {
  String certificationTitle;

  Description({
    required this.certificationTitle,
  });
}

class Skill {
  String skillName;

  Skill({
    required this.skillName,
  });
}

class Language {
  String language;
  String level;

  Language({
    required this.language,
    required this.level,
  });
}

class Certification {
  String certificationName;

  Certification({
    required this.certificationName,
  });
}
