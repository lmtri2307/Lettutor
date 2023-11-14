import 'package:flutter/material.dart';
import 'package:lettutor/models/Topic.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TopicPage extends StatelessWidget {
  const TopicPage({super.key, required this.topic});

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        type: AppBarType.sub,
        title: topic.name,
      ),
      body: SfPdfViewer.network(topic.fileUrl),
    );
  }
}
