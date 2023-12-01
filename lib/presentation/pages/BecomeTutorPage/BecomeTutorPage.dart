import 'package:flutter/material.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/StepWidget.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/ApprovalPage.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/CompleteProfilePage.dart';
import 'package:lettutor/presentation/pages/BecomeTutorPage/sub_pages/VideoIntroductionPage.dart';
import 'package:lettutor/presentation/widgets/PageAppBar/PageAppBar.dart';

class BecomeTutorPage extends StatefulWidget {
  const BecomeTutorPage({super.key});

  final _pages = const [
    CompleteProfilePage(),
    VideoIntroductionPage(),
    ApprovalPage()
  ];

  @override
  State<BecomeTutorPage> createState() => _BecomeTutorPageState();
}

class _BecomeTutorPageState extends State<BecomeTutorPage> {
  int _currentStepIndex = 0;

  Widget _bottomButtonGroup() {
    return _currentStepIndex == 0
        ? Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    _currentStepIndex = _currentStepIndex + 1;
                  });
                },
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                )),
          )
        : Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentStepIndex = _currentStepIndex - 1;
                      });
                    },
                    child: const Text(
                      "Back",
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(width: 12,),
                ElevatedButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentStepIndex = _currentStepIndex + 1;
                      });
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PageAppBar(
        title: "Become Tutor",
        type: AppBarType.sub,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StepWidget(currentIndex: _currentStepIndex),
                  const SizedBox(
                    height: 12,
                  ),
                  widget._pages[_currentStepIndex],
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: _bottomButtonGroup(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
