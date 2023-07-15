import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Widgets/loaderIndicator.dart';
import 'package:group_list_view/group_list_view.dart';

import '../app.dart';
import '../Utilities/constants.dart';
import '../Widgets/regular_teztField.dart';
import '../Widgets/ClassWidgets/class_text_imputs.dart';
import '../Widgets/exam_widget.dart';
import '../Widgets/TaskWidgets/task_widget.dart';
import './class_details_screen.dart';
import './exam_details_screen.dart';
import 'package:my_study_life_flutter/Widgets/ClassWidgets/class_widget.dart';
import '../Widgets/ExtrasWidgets/extras_widget.dart';
import '../Widgets/HolidayWidgets/holiday_widget.dart';
import 'package:dio/dio.dart';

import '../Activities_Screens/holiday_xtra_detail_screen.dart';
import '../Activities_Screens/task_detail_screen.dart';

import '../Models/API/holiday.dart';
import '../Widgets/custom_snack_bar.dart';
import '../Models/API/classmodel.dart';
import '../Models/API/exam.dart';
import '../Models/API/task.dart';
import '../Models/user.model.dart';
import '../Models/API/event.dart';
import '../Activities_Screens/holiday_xtra_detail_screen.dart';
import '../Models/API/xtra.dart';
import '../Networking/search_service.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  static List<Exam> _exams = [];
  static List<ClassModel> _classes = [];
  static List<Xtra> _xtras = [];
  static List<Holiday> _holidays = [];
  static List<Task> _tasks = [];

  void _submitForm(String text, TextFieldType type) {
    if (text.isNotEmpty) {
      _getFilteredExams(text);
    } else {
      setState(() {
        _classes = [];
        _exams = [];
        _tasks = [];
        _xtras = [];
        _holidays = [];
      });
    }
  }

  void _selectedClassCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ClassDetailsScreen(_classes[index]),
            fullscreenDialog: true));
  }

  void _selectedExamCard(IndexPath indexPath) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExamDetailsScreen(
                  examItem: _exams[indexPath.index],
                ),
            fullscreenDialog: true));
  }

  void _selectedTaskCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskDetailsScreen(_tasks[index]),
            fullscreenDialog: true));
  }

  void _selectedHolidayCard(IndexPath index, Holiday item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HolidayXtraDetailScreen(
                  item: item,
                  xtraItem: null,
                ),
            fullscreenDialog: true));
  }

  void _selectedXtrasCard(IndexPath index, Xtra xtraItem) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HolidayXtraDetailScreen(item: null, xtraItem: xtraItem),
            fullscreenDialog: true));
  }

  // API
  Future _getFilteredExams(String filter) async {
    //  DateTime dateTo = date.add(Duration(days: 1));

    // LoadingDialog.show(context);

    try {
      var response = await SearchService().getSearchResults(filter);

      // if (!context.mounted) return;

      //LoadingDialog.hide(context);

      print("RESULTS OH : ${response.data.toString()}");
      // // final classList = (response.data['classes']) as List;
      // // print("CLASSLIST: $classList");
      // // _classes = classList.map((i) => ClassModel.fromJson(i)).toList();
      // // print("CLASSLISTasdad: $_classes");

      setState(() {
        _classes = [];
        _exams = [];
        _tasks = [];
        _xtras = [];
        _holidays = [];

        final classList = (response.data['classes']) as List;
        _classes = classList.map((i) => ClassModel.fromJson(i)).toList();

        final examList = (response.data['exams']) as List;
        _exams = examList.map((i) => Exam.fromJson(i)).toList();

        final taskList = (response.data['tasks']) as List;
        // print("TASKLIST: $taskList");

        _tasks = taskList.map((i) => Task.fromJson(i)).toList();

        final xtrasList = (response.data['xtras']) as List;
        // print("XTRASLIST: $xtrasList");

        _xtras = xtrasList.map((i) => Xtra.fromJson(i)).toList();

        final holidayList = (response.data['holidays']) as List;
        // print("HOLIDAYLIST: $holidayList");

        _holidays = holidayList.map((i) => Holiday.fromJson(i)).toList();
      });
    } catch (error) {
      if (error is DioError) {
        //  LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            error.response?.data['message'], false);
      } else {
        // LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Oops, something went wrong", false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: theme == ThemeMode.light
              ? Constants.lightThemeBackgroundColor
              : Constants.darkThemeBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: theme == ThemeMode.light
                ? Constants.lightThemePrimaryColor
                : Colors.white,
            elevation: 0.0,
            title: Container(
              width: double.infinity,
              height: 53,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: RegularTextField(
                  "Search...",
                  (value) {
                    _submitForm(
                        searchController.text, TextFieldType.moduleName);
                    // FocusScope.of(context).previousFocus();
                  },
                  TextInputType.emailAddress,
                  searchController,
                  theme == ThemeMode.dark,
                  autofocus: true,
                ),
              ),
            ),
          ),
          body:
              // Current Exams
              Container(
            alignment: Alignment.topCenter,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 30),
            child: GroupListView(
              sectionsCount: 5,
              countOfItemInSection: (int section) {
                switch (section) {
                  case 0:
                    return _classes.length;
                  case 1:
                    return _exams.length;
                  case 2:
                    return _tasks.length;
                  case 3:
                    return _holidays.length;
                  case 4:
                    return _xtras.length;
                  default:
                    return _classes.length;
                }
              },
              itemBuilder: (BuildContext context, IndexPath index) {
                switch (index.section) {
                  case 0:
                    return ClassWidget(
                        classItem: _classes[index.index],
                        cardIndex: index.index,
                        upNext: true,
                        cardselected: _selectedClassCard);
                  case 1:
                    return ExamWidget(
                      examItem: _exams[index.index],
                      indexPath: index,
                      upNext: true,
                      cardselected: _selectedExamCard,
                      cardIndex: index.index,
                    );
                  case 2:
                    return TaskWidget(
                        taskItem: _tasks[index.index],
                        cardIndex: index.index,
                        upNext: true,
                        cardselected: _selectedTaskCard);
                  case 3:
                    return HolidayWidget(
                        holidayItem: _holidays[index.index],
                        cardIndex: index,
                        upNext: true,
                        cardselected: _selectedHolidayCard);
                  case 4:
                    return ExtrasWidget(
                        xtraItem: _xtras[index.index],
                        cardIndex: index,
                        upNext: true,
                        cardselected: _selectedXtrasCard);
                  default:
                    return ClassWidget(
                        classItem: _classes[index.index],
                        cardIndex: index.index,
                        upNext: true,
                        cardselected: _selectedClassCard);
                }
              },
              groupHeaderBuilder: (BuildContext context, int section) {
                switch (section) {
                  case 0:
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        _classes.isNotEmpty ? 'Classes (${_classes.length})' : "",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: theme == ThemeMode.light
                              ? Colors.black.withOpacity(0.6)
                              : Colors.white.withOpacity(0.6),
                        ),
                      ),
                    );
                  case 1:
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        _exams.isNotEmpty ? 'Exams (${_exams.length})' : "",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: theme == ThemeMode.light
                              ? Colors.black.withOpacity(0.6)
                              : Colors.white.withOpacity(0.6),
                        ),
                      ),
                    );
                  case 2:
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        _tasks.isNotEmpty ? 'Tasks (${_tasks.length})' : "",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: theme == ThemeMode.light
                              ? Colors.black.withOpacity(0.6)
                              : Colors.white.withOpacity(0.6),
                        ),
                      ),
                    );
                  case 3:
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        _holidays.isNotEmpty ? 'Holidays (${_holidays.length})' : "",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: theme == ThemeMode.light
                              ? Colors.black.withOpacity(0.6)
                              : Colors.white.withOpacity(0.6),
                        ),
                      ),
                    );
                  case 4:
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        _xtras.isNotEmpty ? 'Xtras (${_xtras.length})' : "",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: theme == ThemeMode.light
                              ? Colors.black.withOpacity(0.6)
                              : Colors.white.withOpacity(0.6),
                        ),
                      ),
                    );
                  default:
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Text(
                        _classes.isNotEmpty ? 'Classes (${_classes.length})' : "",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: theme == ThemeMode.light
                              ? Colors.black.withOpacity(0.6)
                              : Colors.white.withOpacity(0.6),
                        ),
                      ),
                    );
                }
              },
              separatorBuilder: (context, index) => SizedBox(height: 10),
              sectionSeparatorBuilder: (context, section) =>
                  SizedBox(height: 10),
            ),
          ),
        ),
      );
    });
  }
}
