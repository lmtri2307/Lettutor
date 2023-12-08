import 'package:flutter/material.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/presentation/pages/TutorSchedulePage/MonthCell.dart';
import 'package:lettutor/presentation/pages/TutorSchedulePage/SlotWidget.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';
import 'package:lettutor/providers/LessonProvider.dart';
import 'package:lettutor/providers/TutorLessonListProvider.dart';
import 'package:lettutor/service/LessonService.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class TutorSchedulePage extends StatefulWidget {
  const TutorSchedulePage({super.key, required this.tutor});

  final Tutor tutor;

  @override
  State<TutorSchedulePage> createState() => _TutorSchedulePageState();
}

class _TutorSchedulePageState extends State<TutorSchedulePage> {
  final _lessonService = const LessonService();


  @override
  void deactivate() {
    final lessonProvider = context.read<LessonProvider>();
    lessonProvider.tutorLessonListProvider = null;
    super.deactivate();
  }

  Widget _monthCellBuilder(BuildContext context, MonthCellDetails details) {
    final theme = Theme.of(context);
    final markerColor = details.appointments.isEmpty
        ? Colors.transparent
        : details.appointments
        .any((element) => (element as Lesson).isAvailable)
        ? theme.primaryColor
        : Colors.grey;
    return MonthCell(markerColor: markerColor, date: details.date);
  }

  Widget _appointmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final lesson = details.appointments.first as Lesson;
    return SlotWidget(
      lesson: lesson,
    );
  }

  Widget _onFetching() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _onHasData(BuildContext context, List<Lesson> lessonList) {
    final theme = Theme.of(context);
    final tutorLessonListProvider =
        TutorLessonListProvider(lessonList: lessonList);
    final lessonLessonProvider = context.read<LessonProvider>();
    lessonLessonProvider.tutorLessonListProvider = tutorLessonListProvider;
    return Scaffold(
      appBar: const PageAppBar(title: "Tutor Timetable", type: AppBarType.sub),
      body: ChangeNotifierProvider(
        create: (context) => tutorLessonListProvider,
        child: Consumer<TutorLessonListProvider>(
          builder: (context, value, child) => SfCalendar(
            // monthViewSettings: ,
            view: CalendarView.month,
            showDatePickerButton: true,
            dataSource: _LessonDataSource(value.lessonList),
            firstDayOfWeek: 1,
            todayHighlightColor: theme.primaryColor,
            showCurrentTimeIndicator: false,
            // onViewChanged: (viewChangedDetails){
            //   print(viewChangedDetails.visibleDates.first);
            //   print(viewChangedDetails.visibleDates.last);
            // },
            showTodayButton: true,
            cellBorderColor: Colors.red,
            showNavigationArrow: true,
            monthCellBuilder: _monthCellBuilder,
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayCount: 1,
              appointmentDisplayMode: MonthAppointmentDisplayMode.none,
              showAgenda: true,
              numberOfWeeksInView: 4,
            ),
            appointmentBuilder: _appointmentBuilder,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _lessonService.getLessonListOfTutor(widget.tutor),
      builder: (context, snapshot) {
        return snapshot.data == null
            ? _onFetching()
            : _onHasData(context, snapshot.data!);
      },
    );
  }
}

class _LessonDataSource extends CalendarDataSource<Lesson> {
  _LessonDataSource(this.lessonList);

  final List<Lesson> lessonList;

  @override
  List<dynamic> get appointments => lessonList;

  @override
  DateTime getStartTime(int index) {
    return lessonList[index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return lessonList[index].endTime;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  @override
  String getSubject(int index) {
    return lessonList[index].isAvailable ? "Book" : "Reserved";
  }

  @override
  Color getColor(int index) {
    return lessonList[index].isAvailable ? Colors.blue : Colors.grey;
  }

  @override
  String? getLocation(int index) {
    return null;
  }
}
