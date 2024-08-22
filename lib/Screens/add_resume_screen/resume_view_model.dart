import 'package:flutter/material.dart';
import 'package:resume_maker/Models/model_resume.dart';
import 'package:resume_maker/Screens/add_resume_screen/resume_2.dart';


class ResumeViewModelProvider extends ChangeNotifier
{
  double _count = 0;

  void setCount(double newCount) {
    _count = newCount;
    notifyListeners();
  }
  double get count => _count;
  final List<ResumeModel> _resumes = [];
  ResumeModel? _currentResume;

  List<Map<String, String>> get resumes
  {
    return _resumes.map((resume)
    {
      return {
        'title': resume.title ?? ' ',
        'job': resume.job ?? ' ',
      };
    }).toList();
  }


  // Set the current resume
  void setCurrentResume(ResumeModel resume) {
    _currentResume = resume;
  }

  // Add a new resume
  void addNewResume(BuildContext context,String newJob,String newTitle) {
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
        certifications: []
    );
    _resumes.add(newResume);
    setCurrentResume(newResume);
    notifyListeners();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Resume_Details(newResumeMdoel: newResume,),
      ),
    );

  }

  // Delete a resume
  void delete(int index) {
    if (index >= 0 && index < _resumes.length) {
      _resumes.removeAt(index);
    }
  }

  // Rename the title of a resume
  void renameTitle(int index, String newTitle,String job) {
    print(job);
    if (index >= 0 && index < _resumes.length) {
      _resumes[index] = ResumeModel(
        title: newTitle,
        job: job,
        intro: _resumes[index].intro,
        contact: _resumes[index].contact,
        education: _resumes[index].education,
        experience: _resumes[index].experience,
        descriptions: _resumes[index].descriptions,
        skills: _resumes[index].skills,
        languages: _resumes[index].languages,
        certifications: _resumes[index].certifications, // Ensure certifications are preserved
      );
    }
  }
  String job_return(index)
  {
    return _resumes[index].job.toString();
  }



  // Edit a resume
  void edit(int index, BuildContext context) {
    if (index >= 0 && index < _resumes.length) {

      final resume = _resumes[index];

      setCurrentResume(resume);
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Resume_Details(newResumeMdoel: resume,index: index,),
        ),
      );
    }
  }


  double calculateFullness(ResumeModel resume)
  {
    double count = 0;
    double divider = (100 / 14);

    if (resume.title.isNotEmpty) count += divider;
    if (resume.job.isNotEmpty) count += divider;
    if (resume.intro!.lastName.isNotEmpty) count += divider;
    if (resume.intro!.firstName.isNotEmpty) count += divider;
    if (resume.intro!.summary.isNotEmpty) count += divider;
    if (resume.contact!.website.isNotEmpty) count += divider;
    if (resume.contact!.email.isNotEmpty) count += divider;
    if (resume.contact!.phoneNumber.isNotEmpty) count += divider;
    if (resume.contact!.address.isNotEmpty) count += divider;
    if (resume.education.isNotEmpty) count += divider;
    if (resume.experience.isNotEmpty) count += divider;
    if (resume.descriptions.isNotEmpty) count += divider;
    if (resume.skills.isNotEmpty) count += divider;
    if (resume.languages.isNotEmpty) count += divider;
    if (resume.certifications.isNotEmpty) count += divider;

    setCount(count);
    notifyListeners();
    return double.parse(count.toStringAsFixed(1));

  }

  void updateFullness(int index) {
    //print('hre');
    final resume = _resumes[index];
    double fullness = calculateFullness(resume);
    resume.fullness = fullness;
    _count =fullness;
    notifyListeners();
  }



  void updateFullness2(ResumeModel resume)
  {
    print('hre24');
    double fullness = calculateFullness(resume);
    resume.fullness = fullness;
    _count =fullness;
    print(resume.fullness);
    print('object');
    notifyListeners();
    print(fullness);
  }

  double getLength(int index) {
    //updateFullness(index);
    updateFullness(index);
    double cut=0;
    _count=_resumes[index].fullness!;

    print(_resumes[index].fullness);
    notifyListeners();
    return _count;
  }

  // Add education to the current resume
  void addEducation(Education education) {
    if (_currentResume != null)
    {
      _currentResume!.education.add(education);
    }
    else
      {
        print('no');
      }
  }

  // Add experience to the current resume
  void addExperience(Experience experience) {
    if (_currentResume != null)
    {
      _currentResume!.experience.add(experience);
    }
  }


  void addCertification(String certificationName) {
    if (_currentResume != null) {
      final newCertification = Certification(certificationName: certificationName);
      _currentResume!.certifications.add(newCertification); // Add the new certification
    }
  }


  void editCertification(int index, Certification updatedCertification) {
    if (_currentResume != null && index >= 0 && index < _currentResume!.certifications.length) {
      _currentResume!.certifications[index] = updatedCertification;
    }
  }

  void addLanguage(Language language) {
    if (_currentResume != null) {
      _currentResume!.languages.add(language);
    }
  }

  void addSkill(Skill skill) {
    if (_currentResume != null) {
      _currentResume!.skills.add(skill);
    }
  }


}
