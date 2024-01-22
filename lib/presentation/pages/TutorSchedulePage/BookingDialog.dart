import 'package:flutter/material.dart';
import 'package:lettutor/models/Lesson.dart';
import 'package:intl/intl.dart';

class BookingDialog extends StatefulWidget {
  const BookingDialog({super.key, required this.lesson, required this.onBook});

  final Lesson lesson;
  final Future<void> Function(String note) onBook;

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  bool _isBooking = false;
  late final TextEditingController noteTextController;

  @override
  void initState() {
    super.initState();
    noteTextController = TextEditingController();
  }


  @override
  void dispose() {
    noteTextController.dispose();
    super.dispose();
  }

  void _onBook(String note) {
    setState(() {
      _isBooking = true;
    });
    widget.onBook(note).then((value) => Navigator.pop(context));
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      surfaceTintColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: const Text("Booking details"),
              actions: const [CloseButton()],
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BookingTime(lesson: widget.lesson),
                  const SizedBox(
                    height: 8,
                  ),
                  const BalancePrice(),
                  const SizedBox(height: 48),
                  Note(noteTextController: noteTextController),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: theme.primaryColor),
                        textStyle: theme.textTheme.bodyLarge),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: theme.primaryColor),
                    onPressed: _isBooking ? () {} : () => _onBook(noteTextController.text),
                    child: IndexedStack(
                        index: _isBooking ? 1 : 0,
                        alignment: Alignment.center,
                        children: [
                          Text(
                            'Book',
                            style: theme.textTheme.bodyLarge
                                ?.copyWith(color: Colors.white),
                          ),
                          const SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ))
                        ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BookingTime extends StatelessWidget {
  const BookingTime({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.grey[100],
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade300))),
            child: Text("Booking Time", style: theme.textTheme.bodySmall),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 238, 234, 255),
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Text(
                  "${DateFormat("HH:mm").format(lesson.startTime)} - ${DateFormat("HH:mm").format(lesson.endTime)} ${DateFormat("EEEE, dd MMMM yyyy").format(lesson.startTime)}",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color.fromARGB(255, 130, 116, 201))),
            ),
          ),
        ],
      ),
    );
  }
}

class BalancePrice extends StatelessWidget {
  const BalancePrice({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Balance",
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text("You have 1 lesson left",
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color.fromARGB(255, 119, 102, 199))),
              )
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Price",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text("1 lesson",
                    textAlign: TextAlign.right,
                    style: theme.textTheme.bodySmall?.copyWith(
                        color: const Color.fromARGB(255, 119, 102, 199))),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class Note extends StatelessWidget {
  const Note({super.key, this.noteTextController });
  final TextEditingController? noteTextController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade300))),
            child: Text(
              "Note",
              style: theme.textTheme.bodySmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: TextField(
                controller: noteTextController,
                minLines: 6,
                maxLines: 6,
                decoration: InputDecoration(
                    isDense: true,
                    border: MaterialStateOutlineInputBorder.resolveWith(
                        (states) => OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ))),
                style: theme.textTheme.bodySmall),
          ),
        ],
      ),
    );
  }
}
