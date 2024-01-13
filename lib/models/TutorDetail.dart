class TutorDetail {
  String? videoUrl;
  final String languages;
  String? interest;
  String? experience;
  String? education;
  int? numOfReviews;

  List<String> get languageList => languages.split(",").toList();

  TutorDetail({this.videoUrl, required this.languages, this.interest, this.experience, this.education, this.numOfReviews});
}
