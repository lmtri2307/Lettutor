import 'package:flutter/material.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:lettutor/service/TutorService.dart';

class TutorReportDialog extends StatefulWidget {
  const TutorReportDialog({super.key, required this.tutor});

  final Tutor tutor;

  @override
  State<TutorReportDialog> createState() => _TutorReportDialogState();
}

class _TutorReportDialogState extends State<TutorReportDialog> {
  final _controller = TextEditingController();
  final _tutorService = const TutorService();
  bool _isReporting = false;
  final List<bool> _choices = [false, false, false];
  final List<String> _contents = const [
    'Inappropriate profile photo',
    'This profile is pretending be someone or is fake',
    'This tutor is annoying me',
  ];

  void _onCancel() {
    Navigator.pop(context, false);
  }

  void _onChoose(int index) {
    final isTicked = !_choices[index];
    if (isTicked) {
      _controller.text = "${_controller.text}${_contents[index]}. ";
    } else {
      _controller.text =
          _controller.text.replaceFirst("${_contents[index]}. ", "");
    }
    setState(() {
      _choices[index] = isTicked;
    });
  }

  Function()? get _onSubmit => _controller.text.isNotEmpty
      ? () async {
          setState(() {
            _isReporting = true;
          });
          await _tutorService
              .report(widget.tutor, _controller.text)
              .then((value) => Navigator.pop(context, true));
        }
      : null;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text(
          'Report Tutor',
          style:
              theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          CloseButton(
            color: Colors.grey,
            onPressed: _onCancel,
          )
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.info,
                  color: theme.primaryColor,
                ),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Help us understand what's happening",
                        maxLines: 2,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ...List<Widget>.generate(_choices.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _choices[index],
                      onChanged: (value) {
                        if (value == null) return;
                        _onChoose(index);
                      },
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () => _onChoose(index),
                              child: Text(
                                _contents[index],
                                style: theme.textTheme.bodySmall,
                              ),
                            ))),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              minLines: 4,
              maxLines: 5,
              style: theme.textTheme.bodySmall,
              onChanged: (value) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Please let us know details about your problems',
                hintStyle:
                    TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
                contentPadding: EdgeInsets.all(12),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(16))),
              ),
            ),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: BorderSide(color: theme.primaryColor),
              textStyle: theme.textTheme.bodyLarge),
          onPressed: _onCancel,
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: theme.primaryColor),
          onPressed: _isReporting ? () {} : _onSubmit,
          child: IndexedStack(
              alignment: Alignment.center,
              index: _isReporting ? 1 : 0,
              children: [
                Text(
                  'Submit',
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox.square(
                    dimension: 20,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ))
              ]),
        ),
      ],
    );
  }
}
