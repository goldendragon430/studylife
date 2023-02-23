import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import '../ClassWidgets/select_subject.dart';
import '../../Models/subjects_datasource.dart';
import '../ClassWidgets/select_class_mode.dart';
import '../ClassWidgets/class_text_imputs.dart';
import '../ClassWidgets/select_times.dart';
import '../ClassWidgets/class_days.dart';
import '../rounded_elevated_button.dart';
import '../switch_row_widget.dart';
import '../ClassWidgets/select_exam_type.dart';
import 'exam_text_imputs.dart';
import 'exam_datetime_duration.dart';

class CreateExam extends StatefulWidget {
  const CreateExam({super.key});

  @override
  State<CreateExam> createState() => _CreateExamState();
}

class _CreateExamState extends State<CreateExam> {
  final ScrollController scrollcontroller = ScrollController();

  bool isExamInPerson = true;
  bool resitOn = false;

  void _subjectSelected(ClassTagItem subject) {
    print("Selected subject: ${subject.title}");
  }

  void _subjectModeSelected(ClassTagItem mode) {
    print("Selected mode: ${mode.title}");

    setState(() {
      if (mode.title == "In Person") {
        isExamInPerson = true;
      } else {
        isExamInPerson = false;
      }
    });
  }

  void _TextInputAdded(String input) {
    print("Selected subject: ${input}");
  }

  void _examTypeSelected(ClassTagItem type) {
    print("Selected repetitionMode: ${type.title}");
  }

  void _switchChangedState(bool isOn) {
    setState(() {
      resitOn = isOn;
      print("Swithc isOn : $isOn");
    });
  }

  void _dateOfExamSelected(DateTime date) {}

  void _timeOfExamSelected(TimeOfDay time) {}

  void _durationOfExamSelected(Duration duration) {}

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
                      SelectSubject(
                        subjectSelected: _subjectSelected,
                      )
                    ],
                    Container(
                      height: 14,
                    ),
                    if (index == 1) ...[
                      // Switch Start dates
                      RowSwitch(
                          title: "Resit",
                          isOn: resitOn,
                          changedState: _switchChangedState)
                    ],
                    if (index == 2) ...[
                      SelectExamType(subjectSelected: _examTypeSelected)
                    ],
                    if (index == 3) ...[
                      // Select Mode
                      SelectClassMode(
                        subjectSelected: _subjectModeSelected,
                      )
                    ],
                    if (index == 4) ...[
                      // Add Text Descriptions
                      ExamTextImputs(
                        subjectSelected: _subjectModeSelected,
                        isExamInPerson: isExamInPerson,
                      )
                    ],
                    if (index == 5) ...[
                      // Select Day,Time, Duration
                      ExamDateTimeDuration(
                          dateSelected: _dateOfExamSelected,
                          timeSelected: _timeOfExamSelected,
                          durationSelected: _durationOfExamSelected),
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
                                "Save Exam",
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
