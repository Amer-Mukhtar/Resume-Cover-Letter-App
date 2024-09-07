import 'package:flutter/material.dart';
import '../../Models/model_cover.dart';
import 'cover_letter_2.dart';

class CoverViewModelProvider extends ChangeNotifier
{


  final List<CoverLetterModel> _coverLetters = [];

  void SetSummary(CoverLetterModel CLM,String summary)
  {
    CLM.summary=summary;
    notifyListeners();

  }
  List<Map<String, String>> get coverLetters {
    return _coverLetters.map((coverLetter) {
      return {
        'title': coverLetter.title ?? '-',
        'summary': coverLetter.summary ?? ' '
      };
    }).toList();
  }

  void addNewCover(BuildContext context) {
    final newCover = CoverLetterModel(
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
  double calculateFullness(CoverLetterModel cover)
  {
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

  void updateFullness2(CoverLetterModel cover)
  {
    print('hre24');
    double fullness = calculateFullness(cover);
    cover.fullness = fullness;

    print('object');
    notifyListeners();

  }

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



