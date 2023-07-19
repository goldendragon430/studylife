import 'package:intl/intl.dart';

class NotificationSetting {
  bool? allReminders;
  bool? sound;
  bool? vibrate;
  bool? classReminders;
  String? classRemindBefore;
  bool? examReminders;
  bool? taskReminders;
  bool? xtraReminders;
  String? xtraRemindBefore;

  NotificationSetting(
      {this.allReminders,
      this.sound,
      this.vibrate,
      this.classReminders,
      this.classRemindBefore,
      this.examReminders,
      this.taskReminders,
      this.xtraReminders,
      this.xtraRemindBefore});

  factory NotificationSetting.fromJson(Map<String, dynamic> json) {
    return NotificationSetting(
        allReminders: json['allReminders'],
        sound: json['sound'],
        vibrate: json['vibrate'],
        classReminders: json['classReminders'],
        examReminders: json['examReminders'],
        taskReminders: json['taskReminders'],
        xtraReminders: json['xtraReminders'],
        xtraRemindBefore: json['xtraRemindBefore']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allReminders'] = allReminders;
    data['sound'] = sound;
    data['vibrate'] = vibrate;
    data['classReminders'] = classReminders;
    data['examReminders'] = examReminders;
    data['taskReminders'] = taskReminders;
    data['xtraReminders'] = xtraReminders;
    data['xtraRemindBefore'] = xtraRemindBefore;

    return data;
  }
}

class NotificationReminder {
  String? type;
  String title;
  bool isOn;
  String? beforeTime;
  String? taskReminderTime;

  NotificationReminder({
    required this.title,
    required this.isOn,
    this.type,
    this.beforeTime,
    this.taskReminderTime,
  });

  static List<NotificationReminder> notificationReminders = [
    NotificationReminder(title: "Reminders", isOn: false),
    NotificationReminder(title: "Sound", isOn: false),
    NotificationReminder(title: "Vibrate", isOn: false),
    NotificationReminder(title: "Class Reminders", isOn: false, type: 'class'),
    NotificationReminder(title: "Exam Reminders", isOn: false, type: 'exam'),
    NotificationReminder(title: "Task Reminders", isOn: false, type: 'task'),
    NotificationReminder(title: "Xtras Reminders", isOn: false, type: 'xtra'),
  ];
}
