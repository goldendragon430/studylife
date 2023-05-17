import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import '../ClassWidgets/select_subject.dart';
import '../../Models/subjects_datasource.dart';
import '../rounded_elevated_button.dart';
import '../TaskWidgets/task_text_imputs.dart';
import './task_datetime.dart';
import './select_tasktype.dart';
import './select_taskOccuring.dart';
import './select_repeatOptions.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final ScrollController scrollcontroller = ScrollController();

  bool isExamInPerson = true;
  bool resitOn = false;

  void _subjectSelected(ClassTagItem subject) {
    print("Selected subject: ${subject.title}");
  }

  void _taskTypeSelected(ClassTagItem taskType) {
    print("Selected task: ${taskType.title}");
  }

  void _TextInputAdded(String input) {
    print("Selected subject: ${input}");
  }

  void _taskOccuringSelected(ClassTagItem occuring) {
    print("Selected repetitionMode: ${occuring.title}");
  }

  void _switchChangedState(bool isOn) {
    setState(() {
      resitOn = isOn;
      print("Swithc isOn : $isOn");
    });
  }

  void _dateOfTaskSelected(DateTime date) {}

  void _taskRepeatOptionSelected(ClassTagItem repeatOption) {
    print("Selected task: ${repeatOption.title}");
  }

  void _tasRepeatDateSelect(DateTime date) {}


  void _timeOfTaskelected(TimeOfDay time) {}

  void _saveClass() {}

  void _cancel() {
   // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        color: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        child: ListView.builder(
            controller: scrollcontroller,
            padding: const EdgeInsets.only(top: 30),
            itemCount: 7,
            itemBuilder: (context, index) {
              if (index == 10) {
                // Save/Cancel Buttons
                return Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 32),
                  // child: RoundedElevatedButton(
                  //     getAllTextInputs, widget.saveButtonTitle, 28),
                );
              } else {
                // Add Questions
                return Column(
                  children: [
                    if (index == 0) ...[
                      // Select Subject
                      // SelectSubject(
                      //   subjectSelected: _subjectSelected,
                      // )
                    ],
                    Container(
                      height: 14,
                    ),
                    if (index == 1) ...[
                      // Switch Start dates
                      TaskTextImputs(
                        formsFilled: _TextInputAdded, labelTitle: 'Title*', hintText: 'Task Title',
                      ),
                    ],
                    if (index == 2) ...[
                      // Select Day,Time, Duration
                      TaskDateTime(
                          dateSelected: _dateOfTaskSelected,
                          timeSelected: _timeOfTaskelected),
                    ],
                    if (index == 3) ...[
                      // Select Subject
                      SelectTaskType(
                        taskSelected: _taskTypeSelected,
                      )
                    ],
                    if (index == 4) ...[
                      // Select Subject
                      SelectTaskOccuring(
                        occuringSelected: _taskOccuringSelected,
                      )
                    ],
                    if (index == 5) ...[
                      // Select Subject
                      SelectTaskRepeatOptions(
                        repeatOptionSelected: _taskRepeatOptionSelected,
                        dateSelected: _tasRepeatDateSelect,
                      )
                    ],
                    if (index == 6) ...[
                      // Save/Cancel buttons
                      Container(
                        height: 68,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        // margin: const EdgeInsets.only(top: 260),
                        padding: const EdgeInsets.only(left: 106, right: 106),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RoundedElevatedButton(
                                _saveClass,
                                "Save Task",
                                Constants.lightThemePrimaryColor,
                                Colors.black,
                                45),
                            RoundedElevatedButton(
                                _cancel,
                                "Cancel",
                                Constants.blueButtonBackgroundColor,
                                Colors.white,
                                45)
                          ],
                        ),
                      ),
                      Container(
                        height: 88,
                      ),
                    ],
                  ],
                );
              }
            }),
      );
    });
  }
}
