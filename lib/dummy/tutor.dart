import 'dart:math';

import 'package:lettutor/dummy/language.dart';
import 'package:lettutor/dummy/specialty.dart';
import 'package:lettutor/dummy/user.dart';
import 'package:lettutor/models/Review.dart';
import 'package:lettutor/models/Tutor.dart';

List<T> getRandomSubList<T>(List<T> list, [T? itemToExclude]) {
  var rng = Random();
  List<T> copy = List<T>.from(list);
  if (itemToExclude == null) copy.remove(itemToExclude);

  int length = rng.nextInt(copy.length) + 1;

  return copy
    ..shuffle(rng)
    ..length = length;
}

List<Review> getRandomReviewList() {
  var rng = Random();
  var length = rng.nextInt(5);
  return List.generate(
      length,
      (index) => Review(
          author: userList[0],
          comment: "Sample Comment",
          rating: rng.nextInt(10) / 2));
}

final tutorList = [
  Tutor(
      name: "Le Minh Tri",
      avatarUrl: "assets/images/keegan-avatar.png",
      rating: 5,
      languageList: getRandomSubList(languageList),
      specialtyList: getRandomSubList(specialtyList),
      reviewList: getRandomReviewList(),
      interest:
          "I am a fun, talkative person who loves to find out about others cultures and experience.",
      experience:
          "Acadsoc - English Language Instruction Chinese based online English teaching platform. I taught EILTS as well as a wide age range of Children and adults of all levels. Sincewin - English Language InstructionOnline English lessons for whole kindergartenclasses. I taught basic phonics and vocabulary using songs,TPR and puppets",
      videoUrl: "assets/videos/tutor.mp4",
      introduction:
          "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia."),
  Tutor(
    name: "Le Minh Tri",
    reviewList: getRandomReviewList(),
    languageList: getRandomSubList(languageList),
    specialtyList: getRandomSubList(specialtyList),
    rating: 3.5,
  ),
  Tutor(
      name: "Le Minh Tri",
      languageList: getRandomSubList(languageList),
      specialtyList: getRandomSubList(specialtyList),
      rating: 4),
  Tutor(
    name: "Le Minh Tri",
    reviewList: getRandomReviewList(),
    languageList: getRandomSubList(languageList),
    specialtyList: getRandomSubList(specialtyList),
  ),
  Tutor(
    name: "Le Minh Tri",
    reviewList: getRandomReviewList(),
    languageList: getRandomSubList(languageList),
    specialtyList: getRandomSubList(specialtyList),
  ),
];
