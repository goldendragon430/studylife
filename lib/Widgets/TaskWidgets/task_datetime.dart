import 'package:flutter/material.dart';
import 'package:my_study_life_flutter/Models/exam_datasource.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app.dart';
import '../../Models/subjects_datasource.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../datetime_selection_textfield.dart';

class TaskDateTime extends StatefulWidget {
  final Function dateSelected;
  final Function timeSelected;

  const TaskDateTime(
      {super.key,
      required this.dateSelected,
      required this.timeSelected,
      });

  @override
  State<TaskDateTime> createState() => _TaskDateTimeState();
}

class _TaskDateTimeState extends State<TaskDateTime> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  late DateTime date = DateTime.now();
  late TimeOfDay pickedTimeFrom = const TimeOfDay(hour: 08, minute: 00);

  @override
  void initState() {
    dateController.text = "Fri, 4 Mar 2023";
    timeController.text = "10:30 AM";
    super.initState();
  }

  void _showiOSDateSelectionDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  // Date pickers

  void _showAndroidDateSelectionDialog(ThemeMode theme, bool isDateFrom) {
    _showAndroidDatePicker(context, theme == ThemeMode.light, isDateFrom);
  }

  Future<void> _showAndroidDatePicker(
      BuildContext context, bool isLightTheme, bool isDateFrom) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: isLightTheme
                    ? Constants.lightThemePrimaryColor
                    : Constants
                        .darkThemeBackgroundColor, // header background color
                onPrimary: isLightTheme
                    ? Colors.black
                    : Constants.darkThemePrimaryColor, // header text color
                onSurface: isLightTheme
                    ? Colors.grey
                    : Constants.darkThemeSecondaryColor, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: isLightTheme
                      ? Colors.black
                      : Constants.darkThemePrimaryColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: date,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2025, 12));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        dateController.text = DateFormat('EEE, d MMM, yyyy').format(picked);
      });
    }
  }

  void _showDatePicker(ThemeMode theme, bool isDateFrom) {
    Platform.isAndroid
        ? _showAndroidDateSelectionDialog
        : _showiOSDateSelectionDialog(CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                date = newDate;
                dateController.text =
                    DateFormat('EEE, d MMM, yyyy').format(newDate);
              });
            },
          ));
  }

  // Time pickers

  void _showAndroidTimeSelectionDialog(ThemeMode theme, bool isDateFrom) {
    _showAndroidTimePicker(context, theme == ThemeMode.light, isDateFrom);
  }

  Future<void> _showAndroidTimePicker(
      BuildContext context, bool isLightTheme, bool isDateFrom) async {
    final TimeOfDay? picked = await showTimePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: TimePickerThemeData(
                backgroundColor: isLightTheme
                    ? Constants.lightThemeBackgroundColor
                    : Constants.darkThemeBackgroundColor,
                hourMinuteColor: isLightTheme
                    ? Colors.grey
                    : Constants.darkThemeSecondaryBackgroundColor,
                hourMinuteTextColor: isLightTheme
                    ? Constants.lightThemePrimaryColor
                    : Constants.darkThemePrimaryColor,
                dayPeriodColor: isLightTheme
                    ? Colors.grey
                    : Constants.darkThemeSecondaryBackgroundColor,
                dayPeriodTextColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.selected)
                        ? isLightTheme
                            ? Constants.lightThemePrimaryColor
                            : Constants.darkThemePrimaryColor
                        : isLightTheme
                            ? Colors.black
                            : Colors.grey),
                dialTextColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.selected)
                        ? isLightTheme
                            ? Constants.lightThemePrimaryColor
                            : Constants.darkThemePrimaryColor
                        : Colors.grey),
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: isLightTheme
                      ? Colors.black
                      : Constants.darkThemePrimaryColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialTime: TimeOfDay(hour: 08, minute: 00));
    if (picked != null) {
      setState(() {
        pickedTimeFrom = picked;
        print(picked.format(context)); //output 10:51 PM
        DateTime parsedTime =
            DateFormat.jm().parse(picked.format(context).toString());
        //converting to DateTime so that we can further format on different pattern.
        print(parsedTime); //output 1970-01-01 22:53:00.000
        String formattedTime = DateFormat('HH:mm:ss').format(parsedTime);
        print(formattedTime);
      });
    }
  }

  void _showTimePicker(ThemeMode theme, bool isDateFrom) {
    Platform.isAndroid
        ? _showAndroidTimeSelectionDialog
        : _showiOSDateSelectionDialog(CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 1,
            initialTimerDuration: Duration.zero,
            onTimerDurationChanged: (Duration changeTimer) {
              setState(() {
                pickedTimeFrom = minutesToTimeOfDay(changeTimer);
                timeController.text = pickedTimeFrom.format(context);
              });
            },
          ));
  }

  TimeOfDay minutesToTimeOfDay(duration) {
    List<String> parts = duration.toString().split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        // Tag items
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Due Date*',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 6,
                      ),
                      DateTimeSelectionTextField(
                        dateController.text,
                        Platform.isAndroid
                            ? _showAndroidDateSelectionDialog
                            : _showDatePicker,
                        textController: dateController,
                        isDateFrom: false,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 6,
                      ),
                      DateTimeSelectionTextField(
                        timeController.text,
                        Platform.isAndroid
                            ? _showAndroidTimeSelectionDialog
                            : _showTimePicker,
                        textController: timeController,
                        isDateFrom: false,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: 6,
            ),            
          ],
        ),
      );
    });
  }
}
