import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Models/exam_datasource.dart';
import '../Models/Services/storage_service.dart';
import '../Models/Services/storage_item.dart';
import '../Widgets/rounded_elevated_button.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import '../../Widgets/loaderIndicator.dart';
import '../../Widgets/custom_snack_bar.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import '../../Models/subjects_datasource.dart';
import '../Widgets/ProfileWidgets/select_first_day.dart';
import '../Widgets/ProfileWidgets/start_time_and_duration.dart';
import '../Widgets/ProfileWidgets/rotation_schedule.dart';
import '../Models/class_datasource.dart';
import '../Widgets/ProfileWidgets/days_to_display.dart';
import '../Widgets/ProfileWidgets/dark_mode_setting.dart';
import '../Widgets/ProfileWidgets/number_of_weeks.dart';
import '../Widgets/ProfileWidgets/start_week.dart';
import '../Widgets/ProfileWidgets/start_day.dart';
import '../Widgets/ProfileWidgets/number_of_days.dart';
import '../Widgets/ClassWidgets/class_days.dart';
import '../Models/user.model.dart';
import '../Models/API/general_settings_model.dart';
import '../Networking/user_service.dart';

enum RotationSchedule { fixed, weekly, lettered }

class GeneralSettingsScreen extends StatefulWidget {
  final Function userUpdated;
  final UserModel? currentUser;
  const GeneralSettingsScreen(
      {super.key, this.currentUser, required this.userUpdated});

  @override
  State<GeneralSettingsScreen> createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  final ScrollController scrollcontroller = ScrollController();
  final StorageService _storageService = StorageService();
  final List<ClassTagItem> _modes = ClassTagItem.lightDarkMode;

  RotationSchedule rotation = RotationSchedule.fixed;
  bool addStartEndDates = false;
  int selectedThemeIndex = 1;
  final List<ClassTagItem> _days = ClassTagItem.startDays;
  GeneralSettingsModel generalSettings = GeneralSettingsModel();

  // void _rotationSelected(RotationSchedule rotationItem) {
  //   print("Selected subject: ${rotationItem}");
  // }

  @override
  void initState() {
    setCurrentData();
    checkSelectedThemeOption();
    super.initState();
  }

  @override
  void dispose() {
    rotation = RotationSchedule.fixed;
    super.dispose();
  }

  void checkSelectedThemeOption() async {
    var appTheme = await _storageService.readSecureData("app_theme");

    if (appTheme == "light") {
      selectedThemeIndex = 2;
    } else if (appTheme == "dark") {
      selectedThemeIndex = 1;
    } else if (appTheme == "system") {
      selectedThemeIndex = 0;
    }

    setState(() {
      _modes[selectedThemeIndex].selected = true;
    });
  }

  void setCurrentData() {
    if (widget.currentUser != null) {
      setState(() {
        if (widget.currentUser?.settingsRotationalSchedule != null) {
          if (widget.currentUser?.settingsRotationalSchedule == "fixed") {
            rotation = RotationSchedule.fixed;
          }
          if (widget.currentUser?.settingsRotationalSchedule == "weekly") {
            rotation = RotationSchedule.weekly;
          }
          if (widget.currentUser?.settingsRotationalSchedule == "lettered") {
            rotation = RotationSchedule.lettered;
          }
        }

        if (widget.currentUser?.settingsFirstDayOfWeek != null) {
          for (var day in _days) {
            day.selected = false;
          }
          _days[widget.currentUser?.settingsFirstDayOfWeek ?? 0].selected =
              true;
          generalSettings.settingsFirstDayOfWeek =
              widget.currentUser?.settingsFirstDayOfWeek;
        }

        if (widget.currentUser?.settingsDaysToDisplayOnDashboard != null) {
          generalSettings.settingsDaysToDisplayOnDashboard =
              widget.currentUser?.settingsDaysToDisplayOnDashboard;
        }

        if (widget.currentUser?.settingsIs24Hour != null) {
          generalSettings.settingsIs24Hour =
              widget.currentUser?.settingsIs24Hour;
        }

        if (widget.currentUser?.settingsDefaultStartTime != null) {
          generalSettings.settingsDefaultStartTime =
              widget.currentUser?.settingsDefaultStartTime;
        }

        if (widget.currentUser?.settingsDefaultStartTime != null) {
          generalSettings.settingsDefaultStartTime =
              widget.currentUser?.settingsDefaultStartTime;
        }

        if (widget.currentUser?.settingsDefaultDuration != null) {
          generalSettings.settingsDefaultDuration =
              widget.currentUser?.settingsDefaultDuration;
        }

        if (widget.currentUser?.settingsRotationalScheduleNumberOfWeeks !=
            null) {
          generalSettings.settingsRotationalScheduleNumberOfWeeks =
              widget.currentUser?.settingsRotationalScheduleNumberOfWeeks;
        }

        if (widget.currentUser?.settingsRotationalScheduleStartWeek != null) {
          generalSettings.settingsRotationalScheduleStartWeek =
              widget.currentUser?.settingsRotationalScheduleStartWeek;
        }

        if (widget.currentUser?.settingsRotationalScheduleStartDay != null) {
          generalSettings.settingsRotationalScheduleStartDay =
              widget.currentUser?.settingsRotationalScheduleStartDay;
        }
        if (widget.currentUser?.settingsRotationalScheduleDays != null) {
          generalSettings.days =
              widget.currentUser?.settingsRotationalScheduleDays;
        }
      });
    }
  }

  void _firstDaySelected(ClassTagItem day) {
    generalSettings.settingsFirstDayOfWeek = day.cardIndex;
  }

  void _dayToDisplaySelected(ClassTagItem day) {
    generalSettings.settingsDaysToDisplayOnDashboard = int.parse(day.title);
  }

  void _numberOfWeeksSelected(ClassTagItem day) {
    generalSettings.settingsRotationalScheduleNumberOfWeeks =
        int.parse(day.title);
  }

  void _startWeekSelected(ClassTagItem day) {
    generalSettings.settingsRotationalScheduleStartWeek = day.title;
  }

  void _numberOfDaysSelected(ClassTagItem day) {
    generalSettings.settingsRotationalScheduleNumberOfDays =
        int.parse(day.title);
  }

  void _startDaySelected(ClassTagItem day) {
    generalSettings.settingsRotationalScheduleStartDay = day.title;
  }

  void _switchedDarkMode(ClassTagItem day, WidgetRef ref) {
    ref.read(themeModeProvider.notifier).state = ThemeMode.light;
  }

  void _classDaysSelected(List<ClassTagItem> days) {
    List<String> daysList = [];
    for (var dayItem in days) {
      if (dayItem.selected) {
        daysList.add(dayItem.title.toLowerCase());
      }
    }
    generalSettings.days = daysList;
  }

  void _classRepetitionSelected(RotationScheduleItem repetition) {
    setState(() {
      rotation = repetition.rotation;
      generalSettings.settingsRotationalSchedule = repetition.rotation.name;
    });
  }

  void _selectedTime(DateTime time) {
    if (widget.currentUser?.settingsIs24Hour != null &&
        widget.currentUser?.settingsIs24Hour == true) {
      final DateFormat formatter = DateFormat('HH:mm');
      final String formatted = formatter.format(time);
      generalSettings.settingsDefaultStartTime = formatted;
      print("Selected repetitionMode: ${formatted}");
    } else {
      final DateFormat formatter = DateFormat('hh:mm');
      final String formatted = formatter.format(time);
      print("Selected repetitionMode: ${formatted}");
      generalSettings.settingsDefaultStartTime = formatted;
    }
  }

  void _selectedDuration(String duration) {
    int intValue = int.parse(duration.replaceAll(RegExp('[^0-9]'), ''));
    generalSettings.settingsDefaultDuration = intValue;
  }

// API

  void updateGeneralSettings() async {
    LoadingDialog.show(context);

    try {
      if (rotation == RotationSchedule.fixed) {
        var response = await UserService().updateGeneralSettings(
            generalSettings.settingsFirstDayOfWeek,
            generalSettings.settingsDefaultStartTime,
            generalSettings.settingsDefaultDuration,
            generalSettings.settingsRotationalSchedule,
            generalSettings.settingsDaysToDisplayOnDashboard.toString(),
            null,
            null,
            null,
            null,
            null);
        if (!context.mounted) return;
        LoadingDialog.hide(context);

        CustomSnackBar.show(context, CustomSnackBarType.success,
            response.data['message'], true);
      }
      if (rotation == RotationSchedule.weekly) {
        var response = await UserService().updateGeneralSettings(
            generalSettings.settingsFirstDayOfWeek,
            generalSettings.settingsDefaultStartTime,
            generalSettings.settingsDefaultDuration,
            generalSettings.settingsRotationalSchedule,
            generalSettings.settingsDaysToDisplayOnDashboard.toString(),
            generalSettings.settingsRotationalScheduleNumberOfWeeks,
            generalSettings.settingsRotationalScheduleStartWeek,
            null,
            null,
            null);
        if (!context.mounted) return;
        LoadingDialog.hide(context);

        CustomSnackBar.show(context, CustomSnackBarType.success,
            response.data['message'], true);
      }
      if (rotation == RotationSchedule.lettered) {
        var response = await UserService().updateGeneralSettings(
            generalSettings.settingsFirstDayOfWeek,
            generalSettings.settingsDefaultStartTime,
            generalSettings.settingsDefaultDuration,
            generalSettings.settingsRotationalSchedule,
            generalSettings.settingsDaysToDisplayOnDashboard.toString(),
            null,
            null,
            generalSettings.settingsRotationalScheduleNumberOfDays,
            generalSettings.settingsRotationalScheduleStartDay,
            generalSettings.days);
        if (!context.mounted) return;
        LoadingDialog.hide(context);

        CustomSnackBar.show(context, CustomSnackBarType.success,
            response.data['message'], true);
      }

      widget.userUpdated();
    } catch (error) {
      if (error is DioError) {
        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            error.response?.data['message'], true);
      } else {
        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Oops, something went wrong", true);
      }
    }
  }

  void _saveSettings() {
    updateGeneralSettings();
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Scaffold(
        backgroundColor: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(
            "General",
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: theme == ThemeMode.light ? Colors.black : Colors.white),
          ),
        ),
        body: Container(
          color: theme == ThemeMode.light
              ? Constants.lightThemeBackgroundColor
              : Constants.darkThemeBackgroundColor,
          child: ListView.builder(
              controller: scrollcontroller,
              padding: const EdgeInsets.only(top: 8),
              itemCount: rotation == RotationSchedule.weekly
                  ? 8
                  : rotation == RotationSchedule.lettered
                      ? 9
                      : 7,
              itemBuilder: (context, index) {
                // Add Questions
                return Column(
                  children: [
                    if (index == 0) ...[
                      // Select First day
                      SelectFirstDay(
                        subjectSelected: _firstDaySelected,
                        days: _days,
                      )
                    ],
                    Container(
                      height: 14,
                    ),
                    if (index == 1) ...[
                      // Select time and Duration
                      StartTimeAndDuration(
                        timeSelected: _selectedTime,
                        durationSelected: _selectedDuration,
                        is24hour: generalSettings.settingsIs24Hour ?? true,
                        selectedStartingTime:
                            generalSettings.settingsDefaultStartTime,
                        defaultDuration:
                            generalSettings.settingsDefaultDuration ?? 30,
                      )
                    ],
                    if (index == 2) ...[
                      // Add Rotation
                      RotationScheduleSelector(
                        rotationSelected: _classRepetitionSelected,
                        rotation: rotation,
                      ),
                      if (rotation == RotationSchedule.fixed) ...[
                        Container(
                          height: 8,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 40),
                          child: Text(
                            "Clases occur on the same day every week",
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeRegular14TextStyle
                                : Constants.darkThemeRegular14TextStyle,
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                      if (rotation == RotationSchedule.weekly) ...[
                        Container(
                          height: 8,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 40),
                          child: Text(
                            "Clases occur on the same day every x weeks",
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeRegular14TextStyle
                                : Constants.darkThemeRegular14TextStyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          height: 16,
                        ),
                        NumberOfWeeks(
                          daySelected: _numberOfWeeksSelected,
                          selectedNumber: generalSettings
                              .settingsRotationalScheduleNumberOfWeeks,
                        ),
                        Container(
                          height: 16,
                        ),
                        StartWeek(
                          startWeekSelected: _startWeekSelected,
                          preselectedWeek: generalSettings
                              .settingsRotationalScheduleStartWeek,
                        ),
                      ],
                      if (rotation == RotationSchedule.lettered) ...[
                        Container(
                          height: 8,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 40),
                          child: Text(
                            "Clases rotate according to the schedule day",
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeRegular14TextStyle
                                : Constants.darkThemeRegular14TextStyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          height: 16,
                        ),
                        NumberOfDays(daySelected: _numberOfDaysSelected),
                        Container(
                          height: 16,
                        ),
                        StartDay(
                            startDaySelected: _startDaySelected,
                            preselectedDay: generalSettings
                                .settingsRotationalScheduleStartDay),
                        Container(
                          height: 16,
                        ),
                        ClassWeekDays(
                            subjectSelected: _classDaysSelected,
                            settingsDates: generalSettings.days)
                      ],
                    ],
                    if (index == 3) ...[
                      // if (rotation == RotationSchedule.fixed) ...[
                      DaysToDisplay(
                        daySelected: _dayToDisplaySelected,
                        selectedDay:
                            generalSettings.settingsDaysToDisplayOnDashboard,
                      )
                      // ],
                    ],
                    if (index == 4) ...[
                      // Select Week days
                      DarkModeSettingh(
                        daySelected: (value) {
                          var mode = value.cardIndex;
                          switch (mode) {
                            case 0:
                              var brightness = WidgetsBinding
                                  .instance.window.platformBrightness;
                              _storageService.writeSecureData(
                                  StorageItem("app_theme", "system"));
                              if (brightness == Brightness.dark) {
                                ref.read(themeModeProvider.notifier).state =
                                    ThemeMode.dark;
                              } else {
                                ref.read(themeModeProvider.notifier).state =
                                    ThemeMode.light;
                              }
                              break;
                            case 1:
                              _storageService.writeSecureData(
                                  StorageItem("app_theme", "dark"));
                              ref.read(themeModeProvider.notifier).state =
                                  ThemeMode.dark;
                              break;
                            case 2:
                              _storageService.writeSecureData(
                                  StorageItem("app_theme", "light"));
                              ref.read(themeModeProvider.notifier).state =
                                  ThemeMode.light;
                          }
                        },
                        selectedIndex: selectedThemeIndex,
                        modes: _modes,
                      )
                    ],
                    if (index == 5) ...[
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
                                _saveSettings,
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
                  ],
                );
                // );
              }),
        ),
      );
    });
  }
}
