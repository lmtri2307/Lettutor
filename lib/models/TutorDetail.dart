class TutorDetail {
  String? videoUrl;
  final String languages;
  String? interest;
  String? experience;

  List<String> get languageList => languages.split(",").toList();

  TutorDetail({this.videoUrl, required this.languages, this.interest, this.experience});
}
