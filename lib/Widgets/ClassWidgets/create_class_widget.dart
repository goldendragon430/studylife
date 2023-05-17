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
import '../switch_row_widget.dart';
import './select_dates.dart';
import 'dart:convert';

import '../../Models/Services/storage_item.dart';
import '../../Models/Services/storage_service.dart';
import '../../Models/API/subject.dart';

class CreateClass extends StatefulWidget {
  const CreateClass({super.key});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  final ScrollController scrollcontroller = ScrollController();
  final StorageService _storageService = StorageService();
  static List<Subject> _subjects = [];

  bool isClassInPerson = true;
  bool addStartEndDates = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getSubjects();
    });
  }

  void getSubjects() async {
    var subjectsData = await _storageService.readSecureData("user_subjects");

    List<dynamic> decodedData = jsonDecode(subjectsData ?? "");

    setState(() {
      _subjects = List<Subject>.from(
        decodedData.map((x) => Subject.fromJson(x as Map<String, dynamic>)),
      );
    });
  }

  void _subjectSelected(Subject subject) {
    for (var savedSubject in _subjects) {
      if (savedSubject.id == subject.id) {
        savedSubject.selected = true;
      }
    }
    print("Selected subject: ${subject.subjectName}");
  }

  void _textInputAdded(String text, TextFieldType type) {
    print("Text $text");
        print("Type $type");

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

  void _selectedDates(DateTime timtimeFromeTo, DateTime timeTo) {
    //print("Selected repetitionMode: ${repetition.title}");
  }

  void _classDaysSelected(List<ClassTagItem> days) {
    print("Selected repetitionMode: ${days}");
  }

  void _switchChangedState(bool isOn) {
    setState(() {
      addStartEndDates = isOn;
      print("Swithc isOn : $isOn");
    });
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
            itemCount: addStartEndDates ? 9 : 8,
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
                        subjectSelected: _subjectSelected, subjects: _subjects, tagtype: TagType.subjects,
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
                        textInputAdded: _textInputAdded,
                        isClassInPerson: isClassInPerson,
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
                        timeSelected: _selectedTimes,
                      )
                    ],
                    if (index == 6) ...[
                      // Switch Start dates
                      RowSwitch(
                          title: "Add Start/end dates?",
                          isOn: addStartEndDates,
                          changedState: _switchChangedState)
                    ],
                    if (addStartEndDates) ...[
                      if (index == 7) ...[
                        SelectDates(dateSelected: _selectedDates),
                      ],
                      if (index == 8) ...[
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
                    if (!addStartEndDates) ...[
                      if (index == 7) ...[
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
                  ],
                );
              }
            }),
      );
    });
  }
}
