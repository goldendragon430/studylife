import 'package:intl/intl.dart';

const secondsPerMinute = 60;
const secondsPerHour = 60 * 60;
const secondsPerDay = 24 * 60 * 60;

class NotificationSetting {
  int? id;
  int? userId;
  String? type;
  int? beforeTime;
  int? status;
  String? taskReminderTime;

  NotificationSetting(
      {this.id,
      this.userId,
      this.type,
      this.beforeTime,
      this.status,
      this.taskReminderTime});

  factory NotificationSetting.fromJson(Map<String, dynamic> json) {
    return NotificationSetting(
        id: json['id'],
        userId: json['userId'],
        type: json['type'],
        beforeTime: json['beforeTime'],
        status: json['status'],
        taskReminderTime: json['taskReminderTime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['type'] = type;
    data['beforeTime'] = beforeTime;
    data['status'] = status;
    data['taskReminderTime'] = taskReminderTime;

    return data;
  }
}

class NotificationReminder {
  String? type;
  String title;
  bool isOn;
  String? beforeTime;
  String? taskReminderTime;
  int? selectedSeconds;

  NotificationReminder({
    required this.title,
    required this.isOn,
    this.type,
    this.beforeTime,
    this.taskReminderTime,
    this.selectedSeconds
  });

  static List<NotificationReminder> notificationReminders = [
    NotificationReminder(title: "Reminders", isOn: false),
    NotificationReminder(title: "Class Reminders", isOn: false, type: 'class'),
    NotificationReminder(title: "Exam Reminders", isOn: false, type: 'exam'),
    NotificationReminder(title: "Task Reminders", isOn: false, type: 'task'),
    NotificationReminder(title: "Xtras Reminders", isOn: false, type: 'xtra'),
  ];
}
