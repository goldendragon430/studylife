import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import '../ClassWidgets/select_subject.dart';
import '../../Models/subjects_datasource.dart';
import '../rounded_elevated_button.dart';
import '../TaskWidgets/task_text_imputs.dart';
import './select_eventType.dart';
import '../ClassWidgets/class_repetition.dart';
import '../ClassWidgets/class_days.dart';
import '../ClassWidgets/select_times.dart';
import '../HolidayWidgets/holiday_text_imputs.dart';
import '../add_photo_widget.dart';

// import './task_datetime.dart';
// import './select_tasktype.dart';
// import './select_taskOccuring.dart';
// import './select_repeatOptions.dart';

class CreateExtra extends StatefulWidget {
  const CreateExtra({super.key});

  @override
  State<CreateExtra> createState() => _CreateExtraState();
}

class _CreateExtraState extends State<CreateExtra> {
  final ScrollController scrollcontroller = ScrollController();

  bool isExamInPerson = true;
  bool resitOn = false;

  void _classRepetitionSelected(ClassTagItem repetition) {
    print("Selected repetitionMode: ${repetition.title}");
  }

  void _extraTypeSelected(ClassTagItem taskType) {
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

  void _classDaysSelected(List<ClassTagItem> days) {
    print("Selected repetitionMode: ${days}");
  }

  void _taskRepeatOptionSelected(ClassTagItem repeatOption) {
    print("Selected task: ${repeatOption.title}");
  }

  void _tasRepeatDateSelect(DateTime date) {}

  void _selectedTimes(DateTime timtimeFromeTo, DateTime timeTo) {
    //print("Selected repetitionMode: ${repetition.title}");
  }
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
                      SelectExtraType(
                        subjectSelected: _extraTypeSelected,
                      )
                    ],
                    Container(
                      height: 14,
                    ),
                    if (index == 1) ...[
                      // Switch Start dates
                      HolidayTextImputs(
                        formsFilled: _TextInputAdded,
                        hintText: 'Name',
                        labelTitle: 'Name*',
                      )
                    ],
                    if (index == 2) ...[
                      // Select Ocurring
                      ClassRepetition(
                        subjectSelected: _classRepetitionSelected,
                      )
                    ],
                    if (index == 3) ...[
                      // Select Week days
                      ClassWeekDays(
                        subjectSelected: _classDaysSelected,
                      )
                    ],
                    if (index == 4) ...[
                      // Select Time From/To
                      SelectTimes(
                        timeSelected: _selectedTimes,
                      )
                    ],
                    if (index == 5) ...[AddPhotoWidget(photoAdded: () => {},)],
                    // if (index == 5) ...[
                    //   // Select Subject
                    //   SelectTaskRepeatOptions(
                    //     repeatOptionSelected: _taskRepeatOptionSelected,
                    //     dateSelected: _tasRepeatDateSelect,
                    //   )
                    // ],
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
