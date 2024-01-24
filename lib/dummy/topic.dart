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
]
    .map((name) => Topic(
        id: name,
        name: name,
        fileUrl:
            "https://api.app.lettutor.com/file/be4c3df8-3b1b-4c8f-a5cc-75a8e2e6626afileYour%20Favorite%20Movie.pdf"
        // "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"
        ))
    .toList();
