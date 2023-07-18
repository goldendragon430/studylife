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
  bool? settingsIs24Hour;

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
      this.settingsIs24Hour,
      this.days});
}

class PersonalSettingsModel {
  String? country;
  int? settingsDateFormat;
  String? timeFormat;
  String? settingsAcademicInterval;
  String? settingsSession;
  String? settingsDaysOff;
  bool? settingsIs24Hour;

  PersonalSettingsModel({
    this.country,
    this.settingsDateFormat,
    this.timeFormat,
    this.settingsAcademicInterval,
    this.settingsSession,
    this.settingsDaysOff,
    this.settingsIs24Hour
  });
}
