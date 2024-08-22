import 'package:flutter/material.dart';
import '../../Models/model_cover.dart';
import 'cover_letter_2.dart';

class AddCover {
  final titleController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final summaryController = TextEditingController();

  newCoverLetterModel createCover() {
    return newCoverLetterModel(
      title: titleController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phoneNumber: phoneController.text,
      email: emailController.text,
      address: addressController.text,
      summary: summaryController.text,
    );
  }

  void dispose() {
    titleController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    summaryController.dispose();
    addressController.dispose();
  }
}

class CoverMode {
  final List<newCoverLetterModel> _coverLetters = [];

  List<Map<String, String>> get coverLetters {
    return _coverLetters.map((coverLetter) {
      return {
        'title': coverLetter.title ?? '-',
        'summary': coverLetter.summary ?? ' '
      };
    }).toList();
  }

  void addNewCover(BuildContext context) {
    final newCover = newCoverLetterModel(
        title: '-',
        summary: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        address: '',
        email: ''
    );
    _coverLetters.add(newCover);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoverLetter(coverLetterModel: newCover),
      ),
    );
  }

  void delete(int index) {
    if (index >= 0 && index < _coverLetters.length) {
      _coverLetters.removeAt(index);
    }
  }

  void renameTitle(int index, String newTitle) {
    if (index >= 0 && index < _coverLetters.length) {
      _coverLetters[index] = newCoverLetterModel(
        title: newTitle,
        summary: _coverLetters[index].summary,
        firstName: _coverLetters[index].firstName,
        lastName: _coverLetters[index].lastName,
        phoneNumber: _coverLetters[index].phoneNumber,
        email: _coverLetters[index].email,
        address: _coverLetters[index].address,
      );
    }
  }

  void edit(int index, BuildContext context) {
    if (index >= 0 && index < _coverLetters.length) {
      final coverLetter = _coverLetters[index];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoverLetter(coverLetterModel: coverLetter),
        ),
      );
    }
  }
}


