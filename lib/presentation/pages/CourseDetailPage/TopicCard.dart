import 'package:flutter/material.dart';
import 'package:lettutor/models/Topic.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({super.key, required this.topic, required this.index});

  final int index;
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Card(
        elevation: 1.5,
        surfaceTintColor: Colors.white,
        child: ListTile(
          title: Text('${index + 1}. ${topic.name}'),
          onTap: () {
            Navigator.pushNamed(context, "/topic", arguments: topic);
          },
        ),
      ),
    );
  }
}
