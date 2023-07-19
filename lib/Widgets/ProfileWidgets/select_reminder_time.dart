import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../datetime_selection_textfield.dart';
import '../../Extensions/extensions.dart';

class SelectReminderTime extends StatefulWidget {
  final Function timeSelected;
  final bool is24hour;
  final String? selectedStartingTime;

  const SelectReminderTime(
      {super.key,
      required this.timeSelected,
      required this.is24hour,
      this.selectedStartingTime});

  @override
  State<SelectReminderTime> createState() => _SelectReminderTimeState();
}

class _SelectReminderTimeState extends State<SelectReminderTime> {
  final timeController = TextEditingController();

  int selectedTabIndex = 0;
  TimeOfDay pickedTimeFrom = const TimeOfDay(hour: 08, minute: 00);
  final now = DateTime.now();

  @override
  void initState() {
    if (widget.selectedStartingTime != null) {
      pickedTimeFrom = TimeOfDay(
          hour: int.parse(widget.selectedStartingTime!.split(":")[0]),
          minute: int.parse(widget.selectedStartingTime!.split(":")[1]));
      timeController.text = pickedTimeFrom.toStringFormat;
    }
    if (!widget.is24hour) {
      timeController.text = formatTimeOfDay(pickedTimeFrom);
    }

    super.initState();
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
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
        initialTime: pickedTimeFrom);
    if (picked != null) {
      setState(() {
        pickedTimeFrom = picked;

        var fullDate = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, picked.hour, picked.minute);
        String formattedDate =
            DateFormat(widget.is24hour ? 'HH:mm' : 'hh:mm').format(fullDate);
        timeController.text = formattedDate;
        widget.timeSelected(fullDate);
      });
    }
  }

  void _showTimePicker(ThemeMode theme, bool isDateFrom) {
    Platform.isAndroid
        ? _showAndroidTimeSelectionDialog
        : _showiOSDateSelectionDialog(CupertinoDatePicker(
            initialDateTime: DateTime(now.year, now.month, now.day,
                pickedTimeFrom.hour, pickedTimeFrom.minute),
            mode: CupertinoDatePickerMode.time,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                String formattedDate =
                    DateFormat(widget.is24hour ? 'HH:mm' : 'hh:mm')
                        .format(newDate);
                timeController.text = formattedDate;
                widget.timeSelected(newDate);
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
          ],
        ),
      );
    });
  }
}
