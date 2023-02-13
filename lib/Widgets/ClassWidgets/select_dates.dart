import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';
import '../regular_teztField.dart';
import '../../app.dart';
import '../../Models/subjects_datasource.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../datetime_selection_textfield.dart';

class SelectDates extends StatefulWidget {
  final Function dateSelected;
  const SelectDates({super.key, required this.dateSelected});

  @override
  State<SelectDates> createState() => _SelectDatesState();
}

class _SelectDatesState extends State<SelectDates> {
  final dateFromController = TextEditingController();
  final dateToController = TextEditingController();

  final List<ClassTagItem> _subjects = ClassTagItem.subjectModes;

  int selectedTabIndex = 0;
  late DateTime dateFrom = DateTime.now();
  late DateTime dateTo = DateTime.now();

  @override
  void initState() {
    dateFromController.text = "Fri, 4 Mar 2023";
    dateToController.text = "Fri, 4 Mar 2023";
    super.initState();
  }

  void _tappedOnDateFrom(ThemeMode theme, bool isDateFrom) {
    _showDatePicker(theme, isDateFrom);
  }

  void _tappedOnDateTo(ThemeMode theme, bool isDateFrom) {
    _showDatePicker(theme, isDateFrom);
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
        initialDate: dateFrom,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2025, 12));
    if (picked != null && picked != (isDateFrom ? dateFrom : dateTo)) {
      setState(() {
        isDateFrom ? dateFrom = picked : dateTo = picked;
        isDateFrom
            ? dateFromController.text =
                DateFormat('EEE, d MMM, yyyy').format(picked)
            : dateToController.text =
                DateFormat('EEE, d MMM, yyyy').format(picked);
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
                  if (isDateFrom) {
                    dateFromController.text =
                        DateFormat('EEE, d MMM, yyyy').format(newDate);
                  } else {
                    dateToController.text =
                        DateFormat('EEE, d MMM, yyyy').format(newDate);
                  }
                });
              },
            ));
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
                        'Start Time*',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 6,
                      ),
                      DateTimeSelectionTextField(
                        dateFromController.text,
                        Platform.isAndroid
                            ? _showAndroidDateSelectionDialog
                            : _showDatePicker,
                        // Platform.isAndroid
                        //     ? _showAndroidDateSelectionDialog
                        //     : () => _showiOSDateSelectionDialog(
                        //             CupertinoTimerPicker(
                        //           mode: CupertinoTimerPickerMode.hm,
                        //           minuteInterval: 1,
                        //           initialTimerDuration: Duration.zero,
                        //           onTimerDurationChanged:
                        //               (Duration changeTimer) {
                        //             setState(() {
                        //               pickedTimeFrom =
                        //                   minutesToTimeOfDay(changeTimer);
                        //               print("ADASDADASDAD $pickedTimeFrom");
                        //             });
                        //           },
                        //         )),
                        textController: dateFromController, isDateFrom: true,
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
                        'End Time',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 6,
                      ),
                      DateTimeSelectionTextField(
                        dateToController.text,
                         Platform.isAndroid
                            ? _showAndroidDateSelectionDialog
                            : _showDatePicker,
                        textController: dateToController, isDateFrom: false,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}