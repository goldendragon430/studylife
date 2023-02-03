import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import 'select_subject.dart';
import '../../Models/subjects_datasource.dart';
import './select_class_mode.dart';
import './class_text_imputs.dart';
import './class_repetition.dart';
import './select_times.dart';
import './class_days.dart';
import '.././rounded_elevated_button.dart';

class CreateClass extends StatefulWidget {
  const CreateClass({super.key});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  final ScrollController scrollcontroller = ScrollController();

  bool isClassInPerson = true;

  void _subjectSelected(ClassTagItem subject) {
    print("Selected subject: ${subject.title}");
  }

  void _subjectModeSelected(ClassTagItem mode) {
    print("Selected mode: ${mode.title}");

    setState(() {
      if (mode.title == "In Person") {
        isClassInPerson = true;
      } else {
        isClassInPerson = false;
      }
    });
  }

  void _TextInputAdded(String input) {
    print("Selected subject: ${input}");
  }

  void _classRepetitionSelected(ClassTagItem repetition) {
    print("Selected repetitionMode: ${repetition.title}");
  }

  void _selectedTimes(DateTime timtimeFromeTo, DateTime timeTo) {
    //print("Selected repetitionMode: ${repetition.title}");
  }

  void _classDaysSelected(List<ClassTagItem> days) {
    print("Selected repetitionMode: ${days}");
  }

  void _saveClass() {}

  void _cancel() {
    Navigator.pop(context);
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
                      // Select Mode
                      SelectClassMode(
                        subjectSelected: _subjectModeSelected,
                      )
                    ],
                    if (index == 2) ...[
                      // Add Text Descriptions
                      ClassTextImputs(
                        subjectSelected: _subjectModeSelected, isClassInPerson: isClassInPerson,
                      )
                    ],
                    if (index == 3) ...[
                      // Select Ocurring
                      ClassRepetition(
                        subjectSelected: _classRepetitionSelected,
                      )
                    ],
                    if (index == 4) ...[
                      // Select Week days
                      ClassWeekDays(
                        subjectSelected: _classDaysSelected,
                      )
                    ],
                    if (index == 5) ...[
                      // Select Time From/To
                      SelectTimes(
                        subjectSelected: _selectedTimes,
                      )
                    ],
                    if (index == 6) ...[
                      // Save/Cancel buttons
                      Container(
                        height: 88,
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
                                "Save Class",
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
