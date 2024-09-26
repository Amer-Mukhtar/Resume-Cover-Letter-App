import 'dart:io';

import 'package:hive/hive.dart';
import '../../Models/model_cover.dart';
import '../../Models/model_resume.dart';

class CLModelAdapter extends TypeAdapter<CoverLetterModel> {
  @override
  final typeId = 10;

  @override
  CoverLetterModel read(BinaryReader reader) {
    return CoverLetterModel(
      summary: reader.readString(),  // Required
      title: reader.readString(),    // Required
      firstName: reader.read() as String?,  // Non-required, may be null
      lastName: reader.read() as String?,   // Non-required, may be null
      phoneNumber: reader.read() as String?, // Non-required, may be null
      email: reader.read() as String?,       // Non-required, may be null
      address: reader.read() as String?,     // Non-required, may be null
      fullness: reader.read() as double?,    // Non-required, may be null
    );
  }

  @override
  void write(BinaryWriter writer, CoverLetterModel obj) {
    writer.writeString(obj.summary);
    writer.writeString(obj.title);
    writer.write(obj.firstName ?? '');
    writer.write(obj.lastName ?? '');
    writer.write(obj.phoneNumber ?? '');
    writer.write(obj.email ?? '');
    writer.write(obj.address ?? '');
    writer.writeDouble(obj.fullness ?? 0.0);
  }
}
