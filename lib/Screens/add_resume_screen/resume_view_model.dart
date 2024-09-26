import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:resume_maker/Models/model_resume.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_2.dart';

class ResumeViewModelProvider extends ChangeNotifier {
  // Hive box to store resumes
  Box<ResumeModel> resumeBox;

  // List of resumes (fetched from Hive)
  List<ResumeModel> _resumes = [];

  ResumeModel? _currentResume;
  double _count = 0;

  ResumeViewModelProvider({required this.resumeBox}) {
    // Load all resumes from the Hive box at the start
    _resumes = resumeBox.values.toList();
  }

  // Get the current list of resumes
  List<Map> get resumes {
    return _resumes.map((resume) {
      return {
        'title': resume.title,
        'job': resume.job,
        'fullness': resume.fullness ?? 0.0,
      };
    }).toList();
  }

  double get count => _count;

  void addNewResume(BuildContext context, String newJob, String newTitle) {
    final newResume = ResumeModel(
      title: newTitle,
      job: newJob,
      fullness: 0,
      intro: Intro(
        firstName: '',
        lastName: '',
        summary: '',
      ),
      contact: Contact(
        email: '',
        phoneNumber: '',
        website: '',
        address: '',
      ),
      education: [],
      experience: [],
      descriptions: [],
      skills: [],
      languages: [],
      certifications: [],
      refrences: [],
      achievements: [],
    );

    resumeBox.add(newResume);
    _resumes = resumeBox.values.toList();
    setCurrentResume(newResume);
    final index = _resumes.length-1;
    notifyListeners();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Resume_Details(newResumeMdoel: newResume,index: index,),
      ),
    );
  }

  // Set the current resume
  void setCurrentResume(ResumeModel resume) {
    updateFullness(resume);
    _currentResume = resume;
  }


  void delete(int index) {
    if (index >= 0 && index < _resumes.length) {
      resumeBox.deleteAt(index); // Delete from Hive
      _resumes = resumeBox.values.toList(); // Reload resumes from Hive
      notifyListeners();
    }
  }

  // Rename the title of a resume
  void renameTitle(int index, String newTitle, String job) {
    if (index >= 0 && index < _resumes.length) {
      final updatedResume = _resumes[index];
      updatedResume.title = newTitle;
      updatedResume.job = job;

      resumeBox.putAt(index, updatedResume); // Update in Hive
      _resumes = resumeBox.values.toList();
      notifyListeners();
    }
  }

  // Get job for a specific resume
  String jobReturn(int index) {
    return _resumes[index].job.toString();
  }

  // Edit an existing resume
  void edit(int index, BuildContext context) {
    if (index >= 0 && index < _resumes.length) {
      final resume = _resumes[index];
      setCurrentResume(resume);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Resume_Details(newResumeMdoel: resume, index: index),
        ),
      );
    }
  }

  // Calculate the fullness of the resume
  double calculateFullness(ResumeModel resume) {
    double count = 0;
    double divider = 100 / 17;

    if (resume.title.isNotEmpty) count += divider;
    if (resume.job.isNotEmpty) count += divider;
    if (resume.intro?.lastName.isNotEmpty ?? false) count += divider;
    if (resume.intro?.firstName.isNotEmpty ?? false) count += divider;
    if (resume.intro?.summary.isNotEmpty ?? false) count += divider;
    if (resume.contact?.website.isNotEmpty ?? false) count += divider;
    if (resume.contact?.email.isNotEmpty ?? false) count += divider;
    if (resume.contact?.phoneNumber.isNotEmpty ?? false) count += divider;
    if (resume.contact?.address.isNotEmpty ?? false) count += divider;
    if (resume.education.isNotEmpty) count += divider;
    if (resume.experience.isNotEmpty) count += divider;
    if (resume.descriptions.isNotEmpty) count += divider;
    if (resume.skills.isNotEmpty) count += divider;
    if (resume.languages.isNotEmpty) count += divider;
    if (resume.certifications.isNotEmpty) count += divider;
    if (resume.achievements.isNotEmpty) count += divider;
    if (resume.profile_image != null) count += divider;
    if (resume.refrences.isNotEmpty) count += divider;
//  if (resume.profile_image != null && resume.profile_image!.existsSync()) count += divider;
    setCount(count);
    notifyListeners();
    return double.parse(count.toStringAsFixed(0));
  }

  // Update fullness of the resume
  void updateFullness(ResumeModel resume) {
    double fullness = calculateFullness(resume);
    resume.fullness = fullness;
    _count = fullness;
    notifyListeners();
  }

  void addEducation(int indexResume,Education education) {
    if (_currentResume != null) {
      final updatedResume = _resumes[indexResume];
      updatedResume!.education.add(education);
      updateFullness(updatedResume!);
      resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
      notifyListeners();
    }
  }
  void deleteEducation(int indexResume,int index) {
    if (_currentResume != null && index >= 0 && index < _currentResume!.education.length) {
      final updatedResume = _resumes[indexResume];
      updatedResume!.education.removeAt(index);
      updateFullness(updatedResume!);
      resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
      notifyListeners();
    }
  }
  void editEducation(int indexResume,int index,Education education) {


    final updatedResume = _resumes[indexResume];
    updatedResume!.education[index]=education;
    updateFullness(updatedResume!);
    resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
    notifyListeners();

  }

  // Add experience to current resume
  void addExperience(int indexResume,Experience experience) {
    if (_currentResume != null) {
      final updatedResume = _resumes[indexResume];
      updatedResume!.experience.add(experience);
      updateFullness(updatedResume!);
      resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
      notifyListeners();
    }
  }
  void deleteExperience(int indexResume,int index) {
    if (_currentResume != null && index >= 0 && index < _currentResume!.experience.length) {
      final updatedResume = _resumes[indexResume];
      updatedResume!.experience.removeAt(index);
      updateFullness(updatedResume!);
      resumeBox.put(updatedResume!.key, updatedResume!);
      notifyListeners();
    }
  }
  void editExperience(int indexResume,int index,Experience experience) {

    final updatedResume = _resumes[indexResume];
    updatedResume!.experience[index]=experience;
    updateFullness(updatedResume!);
    resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
    notifyListeners();

  }

  // Add certification to current resume
  void addCertification(int indexResume,Certification certification) {
    if (_currentResume != null) {
      final updatedResume = _resumes[indexResume];
      updatedResume!.certifications.add(certification);
      updateFullness(updatedResume!);
      resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
      notifyListeners();
    }
  }
  void deleteCertification(int indexResume,int index) {
    if (_currentResume != null && index >= 0 && index < _currentResume!.certifications.length) {
      final updatedResume = _resumes[indexResume];
      updatedResume!.certifications.removeAt(index);
      updateFullness(updatedResume!);
      resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
      notifyListeners();
    }
  }
  void editCertification(int indexResume,int index,Certification certification) {

    final updatedResume = _resumes[indexResume];
    updatedResume!.certifications[index]=certification;
    updateFullness(updatedResume!);
    resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
    notifyListeners();

  }


  void AddFirstName(int indexResume,String intro)
  {
    final updatedResume = _resumes[indexResume];
    updatedResume.intro!.firstName=intro;
    updateFullness(updatedResume);
    resumeBox.put(updatedResume.key, updatedResume);
    notifyListeners();
  }
  void AddLastName(int indexResume,String intro)
  {
    final updatedResume = _resumes[indexResume];
    updatedResume.intro!.lastName=intro;
    updateFullness(updatedResume);
    resumeBox.put(updatedResume.key, updatedResume);
    notifyListeners();
  }
  void AddSummaryName(int indexResume,String intro)
  {
    final updatedResume = _resumes[indexResume];
    updatedResume.intro!.summary=intro;
    updateFullness(updatedResume);
    resumeBox.put(updatedResume.key, updatedResume);
    notifyListeners();
  }
  void AddEmail(int indexResume,String intro)
  {
    final updatedResume = _resumes[indexResume];
    updatedResume.contact!.email=intro;
    updateFullness(updatedResume);
    resumeBox.put(updatedResume.key, updatedResume);
    notifyListeners();
  }
  void AddPhone(int indexResume,String intro)
  {
    final updatedResume = _resumes[indexResume];
    updatedResume.contact!.phoneNumber=intro;
    updateFullness(updatedResume);
    resumeBox.put(updatedResume.key, updatedResume);
    notifyListeners();
  }
  void AddWebsite(int indexResume,String intro)
  {
    final updatedResume = _resumes[indexResume];
    updatedResume.contact!.website=intro;
    updateFullness(updatedResume);
    resumeBox.put(updatedResume.key, updatedResume);
    notifyListeners();
  }
  void AddAddress(int indexResume,String intro)
  {
    final updatedResume = _resumes[indexResume];
    updatedResume.contact!.address=intro;
    updateFullness(updatedResume);
    resumeBox.put(updatedResume.key, updatedResume);
    notifyListeners();
  }

  // Add skill to current resume
  void addSkill(int indexResume,Skill skill)
  {
    if (_currentResume != null) {
      final updatedResume = _resumes[indexResume];
      updatedResume!.skills.add(skill);
      updateFullness(updatedResume);
      resumeBox.put(updatedResume.key, updatedResume);
      notifyListeners();
    }
  }
  void deleteSkill(int indexResume,int index) {
    if (_currentResume != null && index >= 0 && index < _currentResume!.skills.length) {
      final updatedResume = _resumes[indexResume];
      updatedResume!.skills.removeAt(index);
      updateFullness(updatedResume!);
      resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
      notifyListeners();
    }
  }
  void editSkill(int indexResume,int index,Skill skill) {

    final updatedResume = _resumes[indexResume];
    updatedResume!.skills[index]=skill;
    updateFullness(updatedResume!);
    resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
    notifyListeners();

  }

  void addLanguage(int indexResume,Language language) {
    if (_currentResume != null) {
      final updatedResume = _resumes[indexResume];
      updatedResume!.languages.add(language);
      updateFullness(updatedResume!);
      resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
      notifyListeners();
    }
  }
  void deleteLanguage(int indexResume,int index) {
    if (_currentResume != null && index >= 0 && index < _currentResume!.languages.length) {
      final updatedResume = _resumes[indexResume];
      updatedResume!.languages.removeAt(index);
      updateFullness(updatedResume!);
      resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
      notifyListeners();
    }
  }
  void editLangauges(int indexResume,int index,Language language) {

      final updatedResume = _resumes[indexResume];
      updatedResume!.languages[index]=language;
      updateFullness(updatedResume!);
      resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
      notifyListeners();

  }

  void addReference(int indexResume,Reference reference) {
    if (_currentResume != null) {
      final updatedResume = _resumes[indexResume];
      updatedResume!.refrences.add(reference);
      updateFullness(updatedResume!);
      resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
      notifyListeners();
    }
  }
  void editReference(int indexResume,int index,Reference updatedReference) {
    final updatedResume = _resumes[indexResume];
    updatedResume!.refrences[index]=updatedReference;
    updateFullness(updatedResume!);
    resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
    notifyListeners();
  }
  void deleteReference(int indexResume,int index) {
    final updatedResume = _resumes[indexResume];
    updatedResume!.refrences.removeAt(index);
    updateFullness(updatedResume!);
    resumeBox.put(updatedResume!.key, updatedResume!);
    notifyListeners();
  }


  void setResumeSnapshot(Uint8List uint8list, ResumeModel resumeModel) {
    resumeModel.resume_snapshot = uint8list;
    resumeBox.put(resumeModel.key, resumeModel); // Update in Hive
    notifyListeners();
  }

  Uint8List? getResumeSnapshot(int index) {
    if (index >= 0 && index < _resumes.length) {
      return _resumes[index].resume_snapshot;
    } else {
      return null;
    }
  }

  void setCount(double newCount) {
    _count = newCount;
    notifyListeners();
  }


  void setProfileImage(image,index)
  {
    if (index == null)
    {
      return;
    }
    final updatedResume = _resumes[index];
    updatedResume!.profile_image=image;
    resumeBox.put(updatedResume!.key, updatedResume!);
  }


  void addAchievments(int indexResume,Achievements achievements) {
    if (_currentResume != null) {
      final updatedResume = _resumes[indexResume];
      updatedResume.achievements.add(achievements);
      updateFullness(updatedResume);
      resumeBox.put(updatedResume.key, updatedResume);
      notifyListeners();
    }
  }
  void deleteAchievments(int indexResume,int index) {
    if (_currentResume != null && index >= 0 && index < _currentResume!.achievements.length) {
      final updatedResume = _resumes[indexResume];
      updatedResume!.achievements.removeAt(index);
      updateFullness(updatedResume!);
      resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
      notifyListeners();
    }
  }
  void editAchievments(int indexResume,int index,Achievements Achievements) {

    final updatedResume = _resumes[indexResume];
    updatedResume!.achievements[index]=Achievements;
    updateFullness(updatedResume!);
    resumeBox.put(updatedResume!.key, updatedResume!); // Update in Hive
    notifyListeners();

  }

}
