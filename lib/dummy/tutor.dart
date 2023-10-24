import 'dart:math';

import 'package:lettutor/enums/tutor_filter_choice.dart';
import 'package:lettutor/models/Tutor.dart';

List<TutorFilterChoice> getRandomLabelList(
    {List<TutorFilterChoice> list = TutorFilterChoice.values,
    TutorFilterChoice itemToExclude = TutorFilterChoice.all}) {
  var rng = Random();
  List<TutorFilterChoice> copy = List<TutorFilterChoice>.from(list);
  copy.remove(itemToExclude);

  int length = rng.nextInt(copy.length) + 1;

  return copy
    ..shuffle(rng)
    ..length = length;
}

final tutorList = [
  Tutor(
      name: "Le Minh Tri",
      avatarUrl: "assets/images/keegan-avatar.png",
      rating: 5,
      labels: getRandomLabelList(),
      introduction:
          "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia."),
  Tutor(
    name: "Le Minh Tri",
    labels: getRandomLabelList(),
    rating: 3.5,
  ),
  Tutor(name: "Le Minh Tri", labels: getRandomLabelList(), rating: 4),
  Tutor(
    name: "Le Minh Tri",
    labels: getRandomLabelList(),
  ),
  Tutor(
    name: "Le Minh Tri",
    labels: getRandomLabelList(),
  ),
];
