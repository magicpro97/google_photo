import 'package:mime/mime.dart';

extension StringEx on String {
  String get fileName {
    return substring(lastIndexOf('/'));
  }

  String? get mineType {
    return lookupMimeType(this);
  }
}