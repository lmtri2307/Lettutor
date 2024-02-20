import 'dart:math';

import 'package:lettutor/dummy/nationality.dart';
import 'package:lettutor/dummy/review.dart';
import 'package:lettutor/models/Specialty.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/TutorDetail.dart';

List<T> getRandomSubList<T>(List<T> list, [T? itemToExclude]) {
  var rng = Random();
  List<T> copy = List<T>.from(list);
  if (itemToExclude == null) copy.remove(itemToExclude);

  int length = rng.nextInt(copy.length) + 1;

  return copy
    ..shuffle(rng)
    ..length = length;
}

final tutorList = [
  Tutor(
    id: "4d54d3d7-d2a9-42e5-97a2-5ed38af5789a",
    name: "Le Minh Tri",
    avatar: "assets/images/keegan-avatar.png",
    rating: 5,
    specialtyList: getRandomSubList(specialtyList),
    bio:
        "I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.",
    isFavorite: true,
    detail: TutorDetail(
      numOfReviews: Random().nextInt(reviewList.length),
      videoUrl: "assets/videos/tutor.mp4",
      languages: "English",
      interest:
          "I am a fun, talkative person who loves to find out about others cultures and experience.",
      experience:
          "Acadsoc - English Language Instruction Chinese based online English teaching platform. I taught EILTS as well as a wide age range of Children and adults of all levels. Sincewin - English Language InstructionOnline English lessons for whole kindergartenclasses. I taught basic phonics and vocabulary using songs,TPR and puppets",
    ),
    nationality: nationalityList[Random().nextInt(nationalityList.length)],
  ),
  Tutor(
    id: "2",
    name: "Le Minh Tri",
    specialtyList: getRandomSubList(specialtyList),
    rating: 3.5,
    detail: TutorDetail(
        numOfReviews: Random().nextInt(reviewList.length),
        videoUrl: "assets/videos/tutor.mp4",
        languages: "Northern Ndebele"),
    nationality: nationalityList[Random().nextInt(nationalityList.length)],
  ),
  Tutor(
    id: "3",
    name: "Le Minh Tri",
    specialtyList: getRandomSubList(specialtyList),
    rating: 4,
    detail: TutorDetail(
      videoUrl: "assets/videos/tutor.mp4",
      languages: "Walloon, English",
      interest:
          "I am a fun, talkative person who loves to find out about others cultures and experience.",
      experience:
          "Acadsoc - English Language Instruction Chinese based online English teaching platform. I taught EILTS as well as a wide age range of Children and adults of all levels. Sincewin - English Language InstructionOnline English lessons for whole kindergartenclasses. I taught basic phonics and vocabulary using songs,TPR and puppets",
    ),
    nationality: nationalityList[Random().nextInt(nationalityList.length)],
  ),
  Tutor(
    id: "4",
    name: "Le Minh Tri",
    detail: TutorDetail(
      numOfReviews: Random().nextInt(reviewList.length), languages: '',
    ),
    specialtyList: getRandomSubList(specialtyList),
    nationality: nationalityList[Random().nextInt(nationalityList.length)],
  ),
  Tutor(
    id: "5",
    name: "Le Minh Tri",
    detail: TutorDetail(
      numOfReviews: Random().nextInt(reviewList.length), languages: '',
    ),
    specialtyList: getRandomSubList(specialtyList),
    nationality: nationalityList[Random().nextInt(nationalityList.length)],
  ),
];
