import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UpcomingLessonNotification extends StatelessWidget {
  const UpcomingLessonNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              Text(
                'Upcoming Lesson',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 12,),
              Text(
                "Thu, 26 Oct 23 03:30 - 03:55",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 12,),
              Text(
                "(starts in 102:45:40)",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.yellow),
              ),
              const SizedBox(height: 12,),
              TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      backgroundColor: Colors.white),
                  onPressed: (){
                    Navigator.pushNamed(context, "/call");
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.youtube,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 12),
                      Text('Enter Lesson Room',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: Theme.of(context).primaryColor)),
                    ],
                  )),
              const SizedBox(height: 12,),
              Text(
                "Total lesson time is 507 hours 55 minutes",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
