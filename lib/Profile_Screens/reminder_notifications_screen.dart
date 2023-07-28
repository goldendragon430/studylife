import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import '../../Models/Services/storage_service.dart';
import '../Widgets/ProfileWidgets/select_reminder_before.dart';
import '../Widgets/ProfileWidgets/select_reminder_before_exams.dart';
import '../Widgets/ProfileWidgets/select_reminder_before_xtras.dart';
import '../Models/API/notification_setting.dart';
import '../Widgets/switch_row_spaceAround.dart';
import '../../Models/subjects_datasource.dart';
import '../Models/user.model.dart';
import '../Widgets/ProfileWidgets/select_reminder_time.dart';
import '../Widgets/rounded_elevated_button.dart';
import 'package:dio/dio.dart';
import '../../Widgets/loaderIndicator.dart';
import '../../Widgets/custom_snack_bar.dart';
import '../Networking/user_service.dart';
import '../Models/Services/storage_item.dart';

class ReminderNotificationsScreen extends StatefulWidget {
  final UserModel? currentUser;
  final Function notificationsSettingsUpdated;
  const ReminderNotificationsScreen(
      {super.key,
      required this.currentUser,
      required this.notificationsSettingsUpdated});

  @override
  State<ReminderNotificationsScreen> createState() =>
      _ReminderNotificationsScreenState();
}

class _ReminderNotificationsScreenState
    extends State<ReminderNotificationsScreen> {
  final ScrollController scrollcontroller = ScrollController();
  final StorageService _storageService = StorageService();

  final List<NotificationReminder> remindersList =
      NotificationReminder.notificationReminders;

  List<NotificationSetting> savedReminders = [];

  bool classReminders = false;
  bool examReminders = false;
  bool xtraReminders = false;
  bool allReminders = false;

  @override
  void initState() {
    _getData();
    // TODO: implement initState
    super.initState();
  }

  void _getData() async {
    // Get Tasks from storage
    var reminderData = await _storageService.readSecureData("user_reminders");

    List<dynamic> decodedReminders = jsonDecode(reminderData ?? "");

    var allRemindersStatus =
        await _storageService.readSecureData("user_reminders_all_status");

    setState(() {
      if (allRemindersStatus != null) {
        if (allRemindersStatus == 'true') {
          allReminders = true;
        } else {
          allReminders = false;
        }
        // allReminders =
        //     bool.fromEnvironment(allRemindersStatus, defaultValue: false);

        remindersList[0].isOn = allReminders;
      }
      savedReminders = List<NotificationSetting>.from(
        decodedReminders.map(
            (x) => NotificationSetting.fromJson(x as Map<String, dynamic>)),
      );

      for (var reminder in savedReminders) {
        var reminderIndex = remindersList
            .indexWhere((element) => element.type == reminder.type);
        remindersList[reminderIndex].isOn = reminder.status == 0 ? false : true;
        remindersList[reminderIndex].selectedSeconds = reminder.beforeTime;
      }
    });
  }

  void _switchChangedState(bool isOn, int index) {
    setState(() {
      remindersList[index].isOn = isOn;

      if (index == 0) {
        updateNotificationSettings(isOn);
      }
    });
  }

  void _selectedTime(DateTime time) {
    final DateFormat formatter = DateFormat('HH:mm');
    final String formatted = formatter.format(time);
    remindersList[3].taskReminderTime = formatted;
    print("Selected repetitionMode: ${formatted}");
  }

  void _remindClassBeforeSelected(ClassTagItem type) {
    remindersList[1].selectedSeconds = type.durationInSeconds;
  }

  void _remindExamBeforeSelected(ClassTagItem type) {
    remindersList[2].selectedSeconds = type.durationInSeconds;
  }

  void _remindXtraBeforeSelected(ClassTagItem type) {
    remindersList[4].selectedSeconds = type.durationInSeconds;
  }

  void _saveSettings() {
    updateNotificationSettings(null);
  }

  void _cancel() {
    Navigator.pop(context);
  }

  // API

  void updateNotificationSettings(bool? isAllSwitch) async {
    LoadingDialog.show(context);

    if (isAllSwitch != null) {
      try {
        var response = await UserService().updateReminders(isAllSwitch, null);

        final remindersList = (response.data['data']) as List;
        var reminders =
            remindersList.map((i) => NotificationSetting.fromJson(i)).toList();

        _storageService.writeSecureData(
            StorageItem("user_reminders", jsonEncode(reminders)));
        _storageService.writeSecureData(
            StorageItem("user_reminders_all_status", isAllSwitch.toString()));

        if (!context.mounted) return;
        LoadingDialog.hide(context);

        CustomSnackBar.show(context, CustomSnackBarType.success,
            response.data['message'], true);

        // widget.userUpdated();
      } catch (error) {
        if (error is DioError) {
          LoadingDialog.hide(context);
          CustomSnackBar.show(context, CustomSnackBarType.error,
              error.response?.data['message'], true);
        } else {
          print("ERRORCE ${error.toString()}");
          LoadingDialog.hide(context);
          CustomSnackBar.show(context, CustomSnackBarType.error,
              "Oops, something went wrong", true);
        }
      }
    } else {
      for (var i = 1; i < remindersList.length; i++) {
        var reminder = remindersList[i];
        var reminderIndex = savedReminders
            .indexWhere((element) => element.type == reminder.type);
        //print("INDEXX $reminderIndex");
        savedReminders[reminderIndex].status = reminder.isOn ? 1 : 0;
        savedReminders[reminderIndex].beforeTime = reminder.selectedSeconds;
        savedReminders[reminderIndex].taskReminderTime =
            reminder.taskReminderTime;
      }

      try {
        var response =
            await UserService().updateReminders(null, savedReminders);

        final remindersList = (response.data) as List;
        var reminders =
            remindersList.map((i) => NotificationSetting.fromJson(i)).toList();

        _storageService.writeSecureData(
            StorageItem("user_reminders", jsonEncode(reminders)));

        if (!context.mounted) return;
        LoadingDialog.hide(context);

        CustomSnackBar.show(context, CustomSnackBarType.success,
            response.data['message'], true);

        // widget.userUpdated();
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
            "Reminder Notifications",
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: theme == ThemeMode.light ? Colors.black : Colors.white),
          ),
        ),
        body: ListView.builder(
          controller: scrollcontroller,
          padding: const EdgeInsets.only(top: 30),
          itemCount: remindersList[0].isOn ? 6 : 2,
          itemBuilder: (context, index) {
            return Column(
              children: [
                if (index == 0) ...[
                  RowSwitchSpaceAround(
                    title: remindersList[index].title,
                    isOn: remindersList[index].isOn,
                    changedState: _switchChangedState,
                    index: index,
                    bottomBorderOn: true,
                  )
                ],
                // if (index == 1) ...[
                //   RowSwitchSpaceAround(
                //     title: remindersList[index].title,
                //     isOn: remindersList[index].isOn,
                //     changedState: _switchChangedState,
                //     index: index,
                //     bottomBorderOn: true,
                //   )
                // ],
                // if (index == 2) ...[
                //   RowSwitchSpaceAround(
                //     title: remindersList[index].title,
                //     isOn: remindersList[index].isOn,
                //     changedState: _switchChangedState,
                //     index: index,
                //     bottomBorderOn: true,
                //   )
                // ],
                if (index == 1) ...[
                  if (!remindersList[0].isOn) ...[
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
                              "Save Changes",
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
                  if (remindersList[0].isOn) ...[
                    if (remindersList[index].isOn) ...[
                      RowSwitchSpaceAround(
                        title: remindersList[index].title,
                        isOn: remindersList[index].isOn,
                        changedState: _switchChangedState,
                        index: index,
                        bottomBorderOn: false,
                      ),
                      Container(
                        height: 30,
                      ),
                      SelectReminderBefore(
                        reminderSelected: _remindClassBeforeSelected,
                        preselectedSeconds:
                            remindersList[index].selectedSeconds,
                      ),
                      Container(
                        height: 20,
                      ),
                    ],
                    if (!remindersList[index].isOn) ...[
                      RowSwitchSpaceAround(
                        title: remindersList[index].title,
                        isOn: remindersList[index].isOn,
                        changedState: _switchChangedState,
                        index: index,
                        bottomBorderOn: true,
                      )
                    ],
                  ]
                ],
                if (index == 2) ...[
                  if (remindersList[index].isOn) ...[
                    RowSwitchSpaceAround(
                      title: remindersList[index].title,
                      isOn: remindersList[index].isOn,
                      changedState: _switchChangedState,
                      index: index,
                      bottomBorderOn: false,
                    ),
                    Container(
                      height: 30,
                    ),
                    SelectReminderBeforeExams(
                      reminderSelected: _remindExamBeforeSelected,
                      preselectedSeconds: remindersList[index].selectedSeconds,
                    ),
                    Container(
                      height: 20,
                    ),
                  ],
                  if (!remindersList[index].isOn) ...[
                    RowSwitchSpaceAround(
                      title: remindersList[index].title,
                      isOn: remindersList[index].isOn,
                      changedState: _switchChangedState,
                      index: index,
                      bottomBorderOn: true,
                    )
                  ],
                ],
                if (index == 3) ...[
                  if (remindersList[index].isOn) ...[
                    RowSwitchSpaceAround(
                      title: remindersList[index].title,
                      isOn: remindersList[index].isOn,
                      changedState: _switchChangedState,
                      index: index,
                      bottomBorderOn: false,
                    ),
                    Container(
                      height: 10,
                    ),
                    SelectReminderTime(
                        timeSelected: _selectedTime,
                        is24hour: widget.currentUser != null
                            ? widget.currentUser?.settingsIs24Hour ?? false
                            : false),
                    Container(
                      height: 20,
                    ),
                  ],
                  if (!remindersList[index].isOn) ...[
                    RowSwitchSpaceAround(
                      title: remindersList[index].title,
                      isOn: remindersList[index].isOn,
                      changedState: _switchChangedState,
                      index: index,
                      bottomBorderOn: true,
                    )
                  ],

                  // RowSwitchSpaceAround(
                  //   title: remindersList[index].title,
                  //   isOn: remindersList[index].isOn,
                  //   changedState: _switchChangedState,
                  //   index: index,
                  //   bottomBorderOn: false,
                  // ),
                  // Container(
                  //   height: 19,
                  // ),

                  // Container(
                  //   margin: const EdgeInsets.only(left: 40, right: 40),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       Text(
                  //         "Time",
                  //         style: TextStyle(
                  //             fontSize: 15,
                  //             fontFamily: 'Roboto',
                  //             fontWeight: FontWeight.normal,
                  //             color: theme == ThemeMode.light
                  //                 ? Constants.lightThemeTextSelectionColor
                  //                 : Colors.white),
                  //       ),
                  //       const Spacer(),
                  //       Text(
                  //         "6:00PM",
                  //         style: TextStyle(
                  //             fontSize: 15,
                  //             fontFamily: 'Roboto',
                  //             fontWeight: FontWeight.normal,
                  //             color: theme == ThemeMode.light
                  //                 ? Constants.lightThemeTextSelectionColor
                  //                 : Colors.white),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   height: 19,
                  // ),
                ],
                if (index == 4) ...[
                  if (remindersList[index].isOn) ...[
                    RowSwitchSpaceAround(
                      title: remindersList[index].title,
                      isOn: remindersList[index].isOn,
                      changedState: _switchChangedState,
                      index: index,
                      bottomBorderOn: false,
                    ),
                    Container(
                      height: 30,
                    ),
                    SelectReminderBeforeXtras(
                      reminderSelected: _remindXtraBeforeSelected,
                      preselectedSeconds: remindersList[index].selectedSeconds,
                    ),
                    Container(
                      height: 20,
                    ),
                  ],
                  if (!remindersList[index].isOn) ...[
                    RowSwitchSpaceAround(
                      title: remindersList[index].title,
                      isOn: remindersList[index].isOn,
                      changedState: _switchChangedState,
                      index: index,
                      bottomBorderOn: true,
                    )
                  ],
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
                        RoundedElevatedButton(_saveSettings, "Save Changes",
                            Constants.lightThemePrimaryColor, Colors.black, 45),
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
          },
        ),
      );
    });
  }
}
