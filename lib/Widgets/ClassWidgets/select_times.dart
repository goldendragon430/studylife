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

class SelectTimes extends StatefulWidget {
  final Function subjectSelected;
  SelectTimes({super.key, required this.subjectSelected});

  @override
  State<SelectTimes> createState() => _SelectTimesState();
}

class _SelectTimesState extends State<SelectTimes> {
  final timeFromController = TextEditingController();
  final timeToController = TextEditingController();

  final List<ClassTagItem> _subjects = ClassTagItem.subjectModes;

  int selectedTabIndex = 0;
  late TimeOfDay pickedTimeFrom = const TimeOfDay(hour: 08, minute: 00);
  late TimeOfDay pickedTimeTo = const TimeOfDay(hour: 09, minute: 00);

  @override
  void initState() {
    timeFromController.text = "9:00AM";
    timeToController.text = "10:30AM";
    super.initState();
  }

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      for (var item in _subjects) {
        item.selected = false;
      }

      _subjects[index].selected = true;
      widget.subjectSelected(_subjects[index]);
      print("CARD SELECTED $index");
    });
  }

  void _tappedOnTimeFrom() {
    print("TIME FROM");
    _showDatePicker();
  }

  void _tappedOnTimeTo() {
    print("TIME TO");
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

  void _showAndroidDateSelectionDialog(bool isLightTheme) {
    _showAndroidDatePicker(context, isLightTheme);
  }

  Future<void> _showAndroidDatePicker(BuildContext context, bool isLightTheme) async {
    final TimeOfDay? picked = await showTimePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                  primary: Colors.blue, // header background color
                  onPrimary: Colors.white, // header text color
                  onSurface: Colors.green // body text color
                  ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red, // button text color
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

  void _showDatePicker() {
    print("object");
    Platform.isAndroid
        ? _showAndroidDateSelectionDialog
        : () => _showiOSDateSelectionDialog(CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hm,
              minuteInterval: 1,
              initialTimerDuration: Duration.zero,
              onTimerDurationChanged: (Duration changeTimer) {
                setState(() {
                  pickedTimeFrom = minutesToTimeOfDay(changeTimer);
                  print("ADASDADASDAD $pickedTimeFrom");
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
                          timeFromController.text,
                          Platform.isAndroid
                              ? _showAndroidDateSelectionDialog
                              : () => _showiOSDateSelectionDialog(
                                      CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    minuteInterval: 1,
                                    initialTimerDuration: Duration.zero,
                                    onTimerDurationChanged:
                                        (Duration changeTimer) {
                                      setState(() {
                                        pickedTimeFrom =
                                            minutesToTimeOfDay(changeTimer);
                                        print("ADASDADASDAD $pickedTimeFrom");
                                      });
                                    },
                                  )),
                          textController: timeFromController),
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
                          timeToController.text,
                          Platform.isAndroid
                              ? _showAndroidDateSelectionDialog
                              : () => _showiOSDateSelectionDialog(
                                      CupertinoTimerPicker(
                                    mode: CupertinoTimerPickerMode.hm,
                                    minuteInterval: 1,
                                    initialTimerDuration: Duration.zero,
                                    onTimerDurationChanged:
                                        (Duration changeTimer) {
                                      setState(() {
                                        pickedTimeFrom =
                                            minutesToTimeOfDay(changeTimer);
                                        print("ADASDADASDAD $pickedTimeFrom");
                                      });
                                    },
                                  )),
                          textController: timeToController)
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
