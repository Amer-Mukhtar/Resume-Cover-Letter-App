import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../Models/model_cover.dart';
import 'cover_letter_2.dart';

class CoverViewModelProvider extends ChangeNotifier {
  final Box<CoverLetterModel> _coverLettersBox = Hive.box<CoverLetterModel>('cover_letters');

  List<CoverLetterModel> get _coverLetters => _coverLettersBox.values.toList();

  // Save changes to Hive when summary is updated
  void setSummary(CoverLetterModel CLM, String summary) {
    CLM.summary = summary;
    CLM.save();
    notifyListeners();
  }
  void SetFirstName(CoverLetterModel CLM, String summary) {
    CLM.firstName = summary;
    CLM.save();
    notifyListeners();
  }
  void SetFirstLastName(CoverLetterModel CLM, String summary) {
    CLM.lastName = summary;
    CLM.save();
    notifyListeners();
  }
  void SetEmail(CoverLetterModel CLM, String summary) {
    CLM.email = summary;
    CLM.save();
    notifyListeners();
  }
  void SetPhone(CoverLetterModel CLM, String summary) {
    CLM.phoneNumber = summary;
    CLM.save();
    notifyListeners();
  }
  void SetAddress(CoverLetterModel CLM, String summary) {
    CLM.address = summary;
    CLM.save();
    notifyListeners();
  }

  // Get the list of cover letters
  List<Map<String, String>> get coverLetters {
    return _coverLetters.map((coverLetter) {
      return {
        'title': coverLetter.title ?? '-',
        'summary': coverLetter.summary ?? ' '
      };
    }).toList();
  }

  // Add a new cover letter and save it in Hive
  void addNewCover(BuildContext context) {
    final newCover = CoverLetterModel(
        title: '-',
        summary: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        address: '',
        email: '', fullness: 0.0
    );

    _coverLettersBox.add(newCover);  // Add to Hive

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoverLetter(coverLetterModel: newCover),
      ),
    );
  }

  // Delete a cover letter from Hive
  void delete(int index) {
    if (index >= 0 && index < _coverLetters.length) {
      _coverLettersBox.deleteAt(index);  // Delete from Hive
      notifyListeners();
    }
  }

  // Calculate fullness for the cover letter
  double calculateFullness(CoverLetterModel cover) {
    double count = 0;
    double divider = (100 / 7);

    if (cover.title.isNotEmpty) count += divider;
    if (cover.summary.isNotEmpty) count += divider;
    if (cover.firstName!.isNotEmpty) count += divider;
    if (cover.email!.isNotEmpty) count += divider;
    if (cover.address!.isNotEmpty) count += divider;
    if (cover.lastName!.isNotEmpty) count += divider;
    if (cover.phoneNumber!.isNotEmpty) count += divider;

    notifyListeners();
    return double.parse(count.toStringAsFixed(0));
  }

  // Update fullness and save changes in Hive
  void updateFullness2(CoverLetterModel cover) {
    double fullness = calculateFullness(cover);
    cover.fullness = fullness;
    cover.save();
    notifyListeners();
  }

  // Rename title and save the updated cover letter in Hive
  void renameTitle(int index, String newTitle) {
    if (index >= 0 && index < _coverLetters.length) {
      _coverLetters[index] = CoverLetterModel(
        title: newTitle,
        summary: _coverLetters[index].summary,
        firstName: _coverLetters[index].firstName,
        lastName: _coverLetters[index].lastName,
        phoneNumber: _coverLetters[index].phoneNumber,
        email: _coverLetters[index].email,
        address: _coverLetters[index].address,
        fullness: _coverLetters[index].fullness,
      );
      _coverLettersBox.putAt(index, _coverLetters[index]); // Update Hive
      notifyListeners();
    }
  }

  // Edit cover letter by navigating to the edit page
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
