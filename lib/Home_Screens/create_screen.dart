import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app.dart';
import '../Utilities/constants.dart';
import '../../Widgets/loaderIndicator.dart';
import '../../Widgets/custom_snack_bar.dart';
import 'package:dio/dio.dart';

import '../Widgets/ClassWidgets/create_class_widget.dart';
import '../Widgets/ExamWidgets/create_exam.dart';
import '../Widgets/TaskWidgets/create_task.dart';
import '../Widgets/HolidayWidgets/create_holiday.dart';
import '../Widgets/ExtrasWidgets/create_extra.dart';

import '../Models/API/classmodel.dart';
import '../Models/API/exam.dart';
import '../../Networking/class_service.dart';
import '../Home_Screens/home_page.dart';
import '../../Networking/exam_service.dart';
import '../Networking/holiday_Service.dart';
import '../Models/API/holiday.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1600,
      ),
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveClass(ClassModel classItem) async {
    final contextMain = scaffoldMessengerKey.currentContext!;

    // print(classItem.subject);
    // print(classItem.mode);
    // print(classItem.module);
    // print(classItem.room);
    // print(classItem.building);
    // print(classItem.teacher);
    // print(classItem.occurs);
    // print(classItem.startTime);
    // print(classItem.endTime);

    if (classItem.mode == "in-person") {
      if (classItem.subject == null ||
          classItem.mode == null ||
          classItem.module == null ||
          classItem.room == null ||
          classItem.building == null ||
          classItem.teacher == null ||
          classItem.occurs == null ||
          classItem.startTime == null ||
          classItem.endTime == null) {
        CustomSnackBar.show(contextMain, CustomSnackBarType.error,
            "Please fill in all fields.", true);
        return;
      }
    } else {
      if (classItem.subject == null ||
          classItem.mode == null ||
          classItem.module == null ||
          classItem.onlineUrl == null ||
          classItem.teachersEmail == null ||
          classItem.teacher == null ||
          classItem.occurs == null ||
          classItem.startTime == null ||
          classItem.endTime == null) {
        CustomSnackBar.show(contextMain, CustomSnackBarType.error,
            "Please fill in all fields.", true);
        return;
      }
    }

    LoadingDialog.show(context);

    try {
      var response = await ClassService().createClass(classItem);

      if (!contextMain.mounted) return;

      LoadingDialog.hide(context);
      CustomSnackBar.show(contextMain, CustomSnackBarType.success,
          response.data['message'], true);
      Navigator.pop(context);
    } catch (error) {
      if (error is DioError) {
        LoadingDialog.hide(context);
        CustomSnackBar.show(contextMain, CustomSnackBarType.error,
            error.response?.data['message'], true);
      } else {
        LoadingDialog.hide(context);
        CustomSnackBar.show(contextMain, CustomSnackBarType.error,
            "Oops, something went wrong", true);
      }
    }
  }

  void _saveExam(Exam examItem) async {
    final contextMain = scaffoldMessengerKey.currentContext!;

    // print(examItem.subject);
    // print(examItem.mode);
    // print(examItem.module);
    // print(examItem.room);
    // print(examItem.startTime);
    // print(examItem.startDate);
    //     print(examItem.type);
    //     print(examItem.seat);
    //     print(examItem.duration);

    if (examItem.mode == "in-person") {
      if (examItem.subject == null ||
          examItem.mode == null ||
          examItem.module == null ||
          examItem.room == null ||
          examItem.startTime == null ||
          examItem.startDate == null ||
          examItem.type == null ||
          examItem.seat == null ||
          examItem.duration == null) {
        CustomSnackBar.show(contextMain, CustomSnackBarType.error,
            "Please fill in all fields.", true);
        return;
      }
    } else {
      if (examItem.subject == null ||
          examItem.mode == null ||
          examItem.module == null ||
          examItem.startTime == null ||
          examItem.startDate == null ||
          examItem.type == null ||
          examItem.onlineUrl == null ||
          examItem.duration == null) {
        CustomSnackBar.show(contextMain, CustomSnackBarType.error,
            "Please fill in all fields.", true);
        return;
      }
    }

    LoadingDialog.show(context);

    try {
      var response = await ExamService().createExam(examItem);

      if (!contextMain.mounted) return;

      LoadingDialog.hide(context);
      CustomSnackBar.show(contextMain, CustomSnackBarType.success,
          response.data['message'], true);
      Navigator.pop(context);
    } catch (error) {
      if (error is DioError) {
        LoadingDialog.hide(context);
        CustomSnackBar.show(contextMain, CustomSnackBarType.error,
            error.response?.data['message'], true);
      } else {
        LoadingDialog.hide(context);
        CustomSnackBar.show(contextMain, CustomSnackBarType.error,
            "Oops, something went wrong", true);
      }
    }
  }

  void _saveHoliday(Holiday holidayItem) async {
    final contextMain = scaffoldMessengerKey.currentContext!;

     print(holidayItem.title);
    // print(examItem.mode);
    // print(examItem.module);
    // print(examItem.room);
    // print(examItem.startTime);
    // print(examItem.startDate);
    //     print(examItem.type);
    //     print(examItem.seat);
    //     print(examItem.duration);

    if (holidayItem.title == null ||
        holidayItem.startDate == null ||
        holidayItem.endDate == null) {
      CustomSnackBar.show(contextMain, CustomSnackBarType.error,
          "Please fill in all fields.", true);
      return;
    }

    LoadingDialog.show(context);

    try {
      var response = await HolidayService().createHoliday(holidayItem);

      if (!contextMain.mounted) return;

      LoadingDialog.hide(context);
      CustomSnackBar.show(contextMain, CustomSnackBarType.success,
          response.data['message'], true);
      Navigator.pop(context);
    } catch (error) {
      if (error is DioError) {
        LoadingDialog.hide(context);
        CustomSnackBar.show(contextMain, CustomSnackBarType.error,
            error.response?.data['message'], true);
      } else {
        LoadingDialog.hide(context);
        CustomSnackBar.show(contextMain, CustomSnackBarType.error,
            "Oops, something went wrong", true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return BottomSheet(
        animationController: _controller,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            // decoration: BoxDecoration(
            //   color: Colors.red,
            //   borderRadius: BorderRadius.circular(50.0),
            // ),
            child: DefaultTabController(
              length: 5,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: theme == ThemeMode.light
                      ? Constants.lightThemeBackgroundColor
                      : Constants.darkThemeBackgroundColor,
                  shape: Border(
                      bottom: BorderSide(color: Colors.black.withOpacity(0.1))),
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  bottom: TabBar(
                    indicatorWeight: 4,
                    indicatorColor: theme == ThemeMode.light
                        ? Constants.blueButtonBackgroundColor
                        : Constants.darkThemePrimaryColor,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: Text(
                          "Class",
                          style: theme == ThemeMode.light
                              ? Constants.lightThemeTabBarTextStyle
                              : Constants.darkThemeTabBarTextStyle,
                        ),
                      ),
                      Tab(
                          child: Text(
                        "Exam",
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeTabBarTextStyle
                            : Constants.darkThemeTabBarTextStyle,
                      )),
                      Tab(
                          child: Text(
                        "Task",
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeTabBarTextStyle
                            : Constants.darkThemeTabBarTextStyle,
                      )),
                      Tab(
                          child: Text(
                        "Holiday",
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeTabBarTextStyle
                            : Constants.darkThemeTabBarTextStyle,
                      )),
                      Tab(
                          child: Text(
                        "Xtra",
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeTabBarTextStyle
                            : Constants.darkThemeTabBarTextStyle,
                      )),
                    ],
                  ),
                  title: Text(
                    'New',
                    style: theme == ThemeMode.light
                        ? Constants.lightThemeTitleTextStyle
                        : Constants.darkThemeTitleTextStyle,
                  ),
                ),
                body: TabBarView(
                  children: [
                    CreateClass(saveClass: _saveClass),
                    CreateExam(
                      saveExam: _saveExam,
                    ),
                    CreateTask(),
                    CreateHoliday(saveHoliday: _saveHoliday,),
                    CreateExtra(),
                  ],
                ),
                // child: Container(
                //   //to control height of bottom sheet
                //   height: MediaQuery.of(context).size.height * 0.9,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(50.0),
                //   ),
                // ),
              ),
            ),
          );
        },
        onClosing: () {
          // Navigator.pop(context);
        },
      );
    });
  }
}
