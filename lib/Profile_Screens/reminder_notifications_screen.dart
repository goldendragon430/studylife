import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import '../../Models/Services/storage_service.dart';
import '../Widgets/ProfileWidgets/select_reminder_before.dart';
import '../Models/API/notification_setting.dart';
import '../Widgets/switch_row_spaceAround.dart';
import '../../Models/subjects_datasource.dart';
import '../Models/user.model.dart';
import '../Widgets/ProfileWidgets/select_reminder_time.dart';

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

  bool classReminders = false;
  bool examReminders = false;
  bool xtraReminders = false;
  bool allReminders = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _switchChangedState(bool isOn, int index) {
    setState(() {
      remindersList[index].isOn = isOn;
      // if (index == 0) {
      //   allReminders = isOn;
      // }
      // if (index == 3) {
      //   classReminders = isOn;
      // }
      // if (index == 4) {
      //   examReminders = isOn;
      // }
      // if (index == 6) {
      //   xtraReminders = isOn;
      // }
      print("Swithc isOn : $isOn");
    });
  }

  void _selectedTime(DateTime time) {
    if (widget.currentUser?.settingsIs24Hour != null &&
        widget.currentUser?.settingsIs24Hour == true) {
      final DateFormat formatter = DateFormat('HH:mm');
      final String formatted = formatter.format(time);
      print("Selected repetitionMode: ${formatted}");
    } else {
      final DateFormat formatter = DateFormat('hh:mm');
      final String formatted = formatter.format(time);
      print("Selected repetitionMode: ${formatted}");
    }
  }

  void _remindClassBeforeSelected(ClassTagItem type) {
    // print("Selected repetitionMode: ${type.title}");
  }

  void _remindXtraBeforeSelected(ClassTagItem type) {
    // print("Selected repetitionMode: ${type.title}");
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
          itemCount: remindersList[0].isOn ? 7 : 1,
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
                if (index == 1) ...[
                  RowSwitchSpaceAround(
                    title: remindersList[index].title,
                    isOn: remindersList[index].isOn,
                    changedState: _switchChangedState,
                    index: index,
                    bottomBorderOn: true,
                  )
                ],
                if (index == 2) ...[
                  RowSwitchSpaceAround(
                    title: remindersList[index].title,
                    isOn: remindersList[index].isOn,
                    changedState: _switchChangedState,
                    index: index,
                    bottomBorderOn: true,
                  )
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
                      height: 30,
                    ),
                    SelectReminderBefore(
                        reminderSelected: _remindClassBeforeSelected),
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
                    SelectReminderBefore(
                        reminderSelected: _remindClassBeforeSelected),
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
                if (index == 6) ...[
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
                        reminderSelected: _remindXtraBeforeSelected),
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
              ],
            );
          },
        ),
      );
    });
  }
}
