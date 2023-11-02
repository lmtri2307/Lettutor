import 'package:lettutor/models/Topic.dart';

final topicList = [
  "Your Favorite Movie",
  "Your Favorite TV shows",
  "Film Production",
  "The World of Streaming",
  "Competition Shows",
  "Reality TV",
  "TV And Movie Characters",
  "Animated Movies And TV Series",
  "Movies Around the World",
  "The Future of Entertainment"
].map((name) => Topic(name: name)).toList();
