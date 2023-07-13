import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './subject.dart';
import 'package:intl/intl.dart';

class GeneralSettingsModel {
  int? settingsFirstDayOfWeek;
  String? settingsDefaultStartTime;
  int? settingsDefaultDuration;
  String? settingsRotationalSchedule;
  int? settingsDaysToDisplayOnDashboard;
  int? settingsRotationalScheduleNumberOfWeeks;
  String? settingsRotationalScheduleStartWeek;
  int? settingsRotationalScheduleNumberOfDays;
  String? settingsRotationalScheduleStartDay;
  List<String>? days;

  GeneralSettingsModel(
      {this.settingsFirstDayOfWeek,
      this.settingsDefaultStartTime,
      this.settingsDefaultDuration,
      this.settingsRotationalSchedule,
      this.settingsDaysToDisplayOnDashboard,
      this.settingsRotationalScheduleNumberOfWeeks,
      this.settingsRotationalScheduleStartWeek,
      this.settingsRotationalScheduleNumberOfDays,
      this.settingsRotationalScheduleStartDay,
      this.days});
}
