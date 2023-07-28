import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

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
import '../../Models/API/task.dart';
import '../../Models/API/subject.dart';
import '../../Models/Services/storage_service.dart';

class CreateTask extends StatefulWidget {
  final Function saveTask;
  final Task? taskitem;
  final Function deleteTask;
  const CreateTask(
      {super.key,
      required this.saveTask,
      this.taskitem,
      required this.deleteTask});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final ScrollController scrollcontroller = ScrollController();
  static List<Subject> _subjects = [];
  late Task newTask = Task();
  bool isEditing = false;
  final StorageService _storageService = StorageService();
  //final List<ClassTagItem> _occuring = ClassTagItem.taskOccuring;
  final List<ClassTagItem> _taskTypes = ClassTagItem.taskTypes;

  @override
  void initState() {
    super.initState();
    checkForEditedTask();
    Future.delayed(Duration.zero, () {
      getSubjects();
    });
  }

  @override
  void dispose() {
    newTask = Task();
    isEditing = false;
    super.dispose();
  }

  void getSubjects() async {
    var subjectsData = await _storageService.readSecureData("user_subjects");

    List<dynamic> decodedData = jsonDecode(subjectsData ?? "");

    setState(() {
      _subjects = List<Subject>.from(
        decodedData.map((x) => Subject.fromJson(x as Map<String, dynamic>)),
      );
      if (isEditing) {
        var selectedSubjectIndex = _subjects.indexWhere(
            (element) => element.id == widget.taskitem?.subject?.id);
        var selectedSubject = _subjects[selectedSubjectIndex];
        selectedSubject.selected = true;
        _subjects[selectedSubjectIndex] = selectedSubject;
      }
    });
  }

  void _subjectSelected(Subject subject) {
    for (var savedSubject in _subjects) {
      savedSubject.selected = false;
      if (savedSubject.id == subject.id) {
        savedSubject.selected = true;
        newTask.subject = savedSubject;
      }
    }
  }

  void checkForEditedTask() {
    if (widget.taskitem != null) {
      isEditing = true;
      newTask = widget.taskitem!;
    }
  }

  void _taskTypeSelected(ClassTagItem taskType) {
    // print("Selected task: ${taskType.title}");
    newTask.type = taskType.title.toLowerCase();
  }

  void _titleAdded(String text) {
    newTask.title = text;
  }

  void _detailsAdded(String text) {
    newTask.details = text;
  }

  void _taskOccuringSelected(ClassTagItem occuring) {
    newTask.occurs = occuring.title.toLowerCase();
    // print("Selected repetitionMode: ${occuring.title}");
  }

  void _dateOfTaskSelected(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    newTask.dueDate = formattedDate;
  }

  void _taskRepeatOptionSelected(ClassTagItem repeatOption) {
    newTask.repeatOption = repeatOption.title.toLowerCase();
    // print("Selected task: ${repeatOption.title}");
  }

  void _tasRepeatDateSelect(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    newTask.endDate = formattedDate;
  }

  void _timeOfTaskelected(DateTime time) {
    // final localizations = MaterialLocalizations.of(context);
    // final formattedTimeOfDay =
    //     localizations.formatTimeOfDay(time, alwaysUse24HourFormat: true);

    String formattedDate = DateFormat('yyyy-MM-dd').format(time);
    //newTask.startDate = formattedDate;

    // newTask.startTime = formattedTimeOfDay;
  }

  void _saveClass() {
    widget.saveTask(newTask);
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _deleteButtonTapped() {
    widget.deleteTask(newTask);
  }

  //  void _selectedTimes(TimeOfDay time, bool isTimeFrom) {
  //   final localizations = MaterialLocalizations.of(context);
  //   final formattedTimeOfDay =
  //       localizations.formatTimeOfDay(time, alwaysUse24HourFormat: true);

  //   if (isTimeFrom) {
  //     newClass.startTime = formattedTimeOfDay;
  //   } else {
  //     newClass.endTime = formattedTimeOfDay;
  //   }
  // }

  // void _selectedDates(DateTime date, bool isDateFrom) {
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  //   if (isDateFrom) {
  //     newClass.startDate = formattedDate;
  //   } else {
  //     newClass.endDate = formattedDate;
  //   }
  //   print("Selected date: ${date} & ${isDateFrom}");
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          color: theme == ThemeMode.light
              ? Constants.lightThemeBackgroundColor
              : Constants.darkThemeBackgroundColor,
          child: ListView.builder(
              controller: scrollcontroller,
              padding: const EdgeInsets.only(top: 30),
              itemCount: isEditing ? 8 : 7,
              itemBuilder: (context, index) {
                if (index == 10) {
                  // Save/Cancel Buttons
                  return const Padding(
                    padding: EdgeInsets.only(top: 32, bottom: 32),
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
                          subjects: _subjects,
                          tagtype: TagType.subjects,
                        )
                      ],
                      Container(
                        height: 14,
                      ),
                      if (index == 1) ...[
                        // Switch Start dates
                        TaskTextImputs(
                          titleFormFilled: _titleAdded,
                          detailsFormFilled: _detailsAdded,
                          labelTitle: 'Title*',
                          hintText: 'Task Title',
                          taskitem: isEditing ? newTask : null,
                        ),
                      ],
                      if (index == 2) ...[
                        // Select Day,Time, Duration
                        TaskDateTime(
                            dateSelected: _dateOfTaskSelected,
                            timeSelected: _timeOfTaskelected,
                            taskItem: newTask,),
                      ],
                      if (index == 3) ...[
                        // Select Subject
                        SelectTaskType(
                          taskSelected: _taskTypeSelected,
                          preselectedType: newTask.type,
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
                      if (index == 7) ...[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 1,
                              color: theme == ThemeMode.light
                                  ? Colors.black.withOpacity(0.1)
                                  : Colors.white.withOpacity(0.1),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              // width: 142,
                              margin: const EdgeInsets.only(top: 10),
                              child: TextButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                onPressed: _deleteButtonTapped,
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.normal,
                                      color: Constants.overdueTextColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  );
                }
              }),
        ),
      );
    });
  }
}
