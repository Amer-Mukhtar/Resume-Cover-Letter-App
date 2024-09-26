
import 'dart:io';

import 'package:hive/hive.dart';
import '../../Models/model_resume.dart';


class ResumeModelAdapter extends TypeAdapter<ResumeModel> {
  @override
  final typeId = 0;

  @override
  ResumeModel read(BinaryReader reader) {
    return ResumeModel(
      title: reader.readString(),
      job: reader.readString(),
      profile_image: reader.read(),
      intro: reader.read() as Intro?,
      fullness: reader.readDouble(),
      contact: reader.read() as Contact?,
      education: reader.readList().cast<Education>(),
      experience: reader.readList().cast<Experience>(),
      descriptions: reader.readList().cast<Description>(),
      skills: reader.readList().cast<Skill>(),
      languages: reader.readList().cast<Language>(),
      certifications: reader.readList().cast<Certification>(),
      refrences: reader.readList().cast<Reference>(),
      resume: reader.read() as File?,
      resume_snapshot: reader.read(),
      achievements: reader.readList().cast<Achievements>(),
    );
  }

  @override
  void write(BinaryWriter writer, ResumeModel obj) {
    // Write all fields in the same order they are read
    writer.writeString(obj.title);
    writer.writeString(obj.job);
    writer.write(obj.profile_image);
    writer.write(obj.intro);
    writer.writeDouble(obj.fullness ?? 0.0);
    writer.write(obj.contact);
    writer.writeList(obj.education);
    writer.writeList(obj.experience);
    writer.writeList(obj.descriptions);
    writer.writeList(obj.skills);
    writer.writeList(obj.languages);
    writer.writeList(obj.certifications);
    writer.writeList(obj.refrences);
    writer.write(obj.resume); // Handle file path or representation
    writer.write(obj.resume_snapshot);
    writer.writeList(obj.achievements);
  }
}

class IntroAdapter extends TypeAdapter<Intro> {
  @override
  final typeId = 1;

  @override
  Intro read(BinaryReader reader) {
    return Intro(
      firstName: reader.readString(),
      lastName: reader.readString(),
      summary: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Intro obj) {
    writer.writeString(obj.firstName);
    writer.writeString(obj.lastName);
    writer.writeString(obj.summary);
  }
}
class ContactAdapter extends TypeAdapter<Contact> {
  @override
  final typeId = 2;

  @override
  Contact read(BinaryReader reader) {
    return Contact(
      email: reader.readString(),
      phoneNumber: reader.readString(),
      website: reader.readString(),
      address: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Contact obj) {
    writer.writeString(obj.email);
    writer.writeString(obj.phoneNumber);
    writer.writeString(obj.website);
    writer.writeString(obj.address);
  }
}
class EducationAdapter extends TypeAdapter<Education> {
  @override
  final typeId = 3;

  @override
  Education read(BinaryReader reader) {
    return Education(
      schoolTitle: reader.readString(),
      major: reader.readString(),
      from: reader.readString(),
      to: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Education obj) {
    writer.writeString(obj.schoolTitle);
    writer.writeString(obj.major);
    writer.writeString(obj.from);
    writer.writeString(obj.to);
  }
}
class ExperienceAdapter extends TypeAdapter<Experience> {
  @override
  final typeId = 4;

  @override
  Experience read(BinaryReader reader) {
    return Experience(
      company: reader.readString(),
      position: reader.readString(),
      location: reader.readString(),
      from: reader.readString(),
      to: reader.readString(),
      description: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Experience obj) {
    writer.writeString(obj.company);
    writer.writeString(obj.position);
    writer.writeString(obj.location);
    writer.writeString(obj.from);
    writer.writeString(obj.to);
    writer.writeString(obj.description);
  }
}


class SkillAdapter extends TypeAdapter<Skill> {
  @override
  final typeId = 5;

  @override
  Skill read(BinaryReader reader) {
    return Skill(
      skillName: reader.readString(),
      level: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Skill obj) {
    writer.writeString(obj.skillName);
    writer.writeDouble(obj.level);
  }
}

class LanguageAdapter extends TypeAdapter<Language> {
  @override
  final typeId = 6;

  @override
  Language read(BinaryReader reader) {
    return Language(
      language: reader.readString(),
      level: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Language obj) {
    writer.writeString(obj.language);
    writer.writeString(obj.level);
  }
}
class CertificationAdapter extends TypeAdapter<Certification> {
  @override
  final typeId = 7;

  @override
  Certification read(BinaryReader reader) {
    return Certification(
      certificationName: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Certification obj) {
    writer.writeString(obj.certificationName);
  }
}
class ReferenceAdapter extends TypeAdapter<Reference> {
  @override
  final typeId = 8;

  @override
  Reference read(BinaryReader reader) {
    return Reference(
      name: reader.readString(),
      company: reader.readString(),
      position: reader.readString(),
      phone: reader.readString(),
      email: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Reference obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.company);
    writer.writeString(obj.position);
    writer.writeString(obj.phone);
    writer.writeString(obj.email);
  }
}

class AchievementsAdapter extends TypeAdapter<Achievements> {
  @override
  final typeId = 9;

  @override
  Achievements read(BinaryReader reader) {
    return Achievements(
      name: reader.readString(),
      Descirption: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Achievements obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.Descirption);
  }
}
