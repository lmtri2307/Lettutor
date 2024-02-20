import 'package:lettutor/helpers/date_helper.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/models/User.dart';
import 'package:lettutor/repository/LessonRepository.dart';
import 'package:lettutor/repository/UserRepository.dart';
import 'package:omni_jitsi_meet/jitsi_meet.dart';

class LessonService {
  const LessonService();

  final _lessonRepository = const LessonRepository();
  final _userRepository = const UserRepository();

  Future<List<BookedLesson>> getNextLessonList() async {
    final lessonList = await _userRepository.getNextLessonList();
    lessonList.sort((a, b) => a.startTime.compareTo(b.startTime));
    return lessonList;
  }

  Future<BookedLesson?> getUpcomingLesson() async {
    final lessonList = await getNextLessonList();
    if (lessonList.isEmpty) {
      return null;
    }
    return lessonList.first;
  }

  Future<List<Lesson>> getLessonListOfTutor(Tutor tutor, int page) async {
    final lessonList =
        await _lessonRepository.getLessonListOfTutor(tutor, page);
    lessonList.sort((a, b) => a.startTime.compareTo(b.startTime));
    return lessonList;
  }

  Future<Lesson> bookLesson(Lesson lesson, String note) async {
    await _lessonRepository.bookLesson(lesson, note);

    final resultLesson = lesson.copyWith(isAvailable: false);
    return resultLesson;
  }

  Future<Duration> getTotalLessonTime() async {
    return await _userRepository.getTotalLessonTime();
  }

  Future<(List<BookedLesson>, int)> getScheduleLessonList(
      int page, int perPage) async {
    final (lessonList, count) =
        await _userRepository.getScheduleLessonList(page, perPage);
    return (
      const DateHelper().sortByDate(lessonList, (item) => item.startTime),
      count
    );
  }

  Future<(List<Lesson>, int)> getHistoryLessonList(
      int page, int perPage) async {
    final (historyLessonList, count) =
        await _userRepository.getHistoryLessonList(page, perPage);
    return (
      const DateHelper().sortByDate(historyLessonList, (item) => item.startTime,
          ascending: false),
      count
    );
  }

  Future<void> cancelLesson(Lesson lesson) async {
    // check if lesson is 2 hours before now
    if (DateTime.now()
        .isAfter(lesson.startTime.subtract(const Duration(hours: 24)))) {
      throw Exception("Can't cancel lesson 2 hours before start time");
    }
    await _lessonRepository.cancelLesson(lesson);
  }

  Future<void> joinLessonMeeting(User user, BookedLesson lesson) async {
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    // if (!kIsWeb) {
    //   if (Platform.isAndroid) {
    //     featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
    //   } else if (Platform.isIOS) {
    //     featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
    //   }
    // }
    final room = '${user.id}-${lesson.tutor.id}';
    final options = JitsiMeetingOptions(
        room: room,
        serverURL: 'https://meet.lettutor.com',
        audioOnly: true,
        audioMuted: true,
        videoMuted: true,
        token: lesson.token,
        // webOptions: {
        //   'roomName': room, // Use your specific room name
        //   'width': '100%',
        //   'height': '100%',
        //   'jwt': lesson.token,
        //   'enableWelcomePage': false,
        //   'enableNoAudioDetection': true,
        //   'enableLobbyChat': false,
        //   'enableNoisyMicDetection': true,
        //   'enableClosePage': false,
        //   'disableRemoveRaisedHandOnFocus': false,
        //   'disableReactions': true,
        //   'prejoinPageEnabled': false,
        //   'hideDisplayName': true,
        //   'hideConferenceSubject': true,
        //   'hideConferenceTimer': true,
        //   'hideParticipantsStats': true,
        //   'hideLobbyButton': true,
        //   'disableInviteFunctions': true,
        //   'chromeExtensionBanner': null,
        //   'readOnlyName': true,
        //   // 'parentNode': html.document.body.,
        //   // Add other web options as needed
        // },
        featureFlags: featureFlags);

    await JitsiMeet.joinMeeting(options);
  }
}
