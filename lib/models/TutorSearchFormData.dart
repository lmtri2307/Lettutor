import 'package:lettutor/models/Specialty.dart';
import 'package:lettutor/models/Nationality.dart';

class TutorSearchFormData {
  String? name;
  Nationality? tutorNationality;
  Specialty? specialty;

  TutorSearchFormData({this.name, this.tutorNationality, this.specialty});
}
