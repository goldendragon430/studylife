import 'package:flutter/material.dart';

class HolidayItem {
  final String title;
  final DateTime dateFrom;
  DateTime? dateTo;
  String? holidayImage;

  HolidayItem(
      {required this.title,
      required this.dateFrom,
      this.dateTo,
      this.holidayImage});

  static List<HolidayItem> holidays = [
    HolidayItem(dateFrom: DateTime.now(), title: "Doctor's appointment"),
    HolidayItem(
      title: 'Trekking trip to Yosemite as planned with Mike in Dec',
      dateFrom: DateTime.now().add(const Duration(days: 1)),
      dateTo: DateTime.now().add(const Duration(days: 2)),
      holidayImage: 'assets/images/MountainHolidayImage.png',
    ),
    HolidayItem(
        dateFrom: DateTime.now().add(const Duration(days: 10)),
        title: "Training Day"),
    HolidayItem(
      title: 'Family Meet',
      dateFrom: DateTime.now().add(const Duration(days: 12)),
      dateTo: DateTime.now().add(const Duration(days: 15)),
      holidayImage: 'assets/images/MountainHolidayImage.png',
    ),
  ];

   static List<HolidayItem> extras = [
    HolidayItem(dateFrom: DateTime.now(), title: "Free class"),
    HolidayItem(
      title: 'Lunch Break',
      dateFrom: DateTime.now().add(const Duration(days: 1)),
      dateTo: DateTime.now().add(const Duration(days: 2)),
      holidayImage: 'assets/images/MountainHolidayImage.png',
    ),
  ];
}
