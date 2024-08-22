import 'package:flutter/material.dart';
import 'package:resume_maker/Models/model_resume.dart';

class Resumelength {
  final List<ResumeModel> _resumes;

  Resumelength(this._resumes);

  double length(int index) {
    if (index < 0 || index >= _resumes.length) {
      throw IndexError(index, _resumes, 'Invalid index');
    }

    final resume = _resumes[index];
    double count = 0;
    double divider = 100 / 14;

    // Check various fields of the resume and increment the count
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

    // Ensure the count is capped at 100
    count = count > 100 ? 100 : count;

    print(count);
    return count;
  }
}
