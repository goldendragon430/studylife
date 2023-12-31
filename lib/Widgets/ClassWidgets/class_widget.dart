import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:intl/intl.dart';

import '../../app.dart';
import '../../Models/class_datasource.dart';
import '../../Models/API/classmodel.dart';
import '../../Utilities/constants.dart';
import '../../Extensions/extensions.dart';
import '../../Models/API/event.dart';

class ClassWidget extends ConsumerWidget {
  final int cardIndex;
  final bool upNext;

  final ClassModel? classItem;
  final Event? eventItem;
  final Function cardselected;

  const ClassWidget(
      {super.key,
      this.classItem,
      required this.cardIndex,
      required this.upNext,
      required this.cardselected,
      this.eventItem});

  void _cardTapped() {
    cardselected(cardIndex);
  }

  String _getFormattedTime() {
    if (classItem != null) {
      TimeOfDay startTime = toTimeOfDay(classItem!.startTime);
      TimeOfDay endTime = toTimeOfDay(classItem!.endTime);

      var fullStartDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, startTime.hour, startTime.minute);

      var fullEndDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, endTime.hour, endTime.minute);

      var outputFormat = DateFormat('HH:mm');
      var outputDateStart = outputFormat.format(fullStartDate);
      var outputDateEnd = outputFormat.format(fullEndDate);

      return "${outputDateStart.toString()} - ${outputDateEnd.toString()}";
    } else {
      TimeOfDay startTime = toTimeOfDay(eventItem!.startTime);
      TimeOfDay endTime = toTimeOfDay(eventItem!.endTime);

      var fullStartDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, startTime.hour, startTime.minute);

      var fullEndDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, endTime.hour, endTime.minute);

      var outputFormat = DateFormat('HH:mm');
      var outputDateStart = outputFormat.format(fullStartDate);
      var outputDateEnd = outputFormat.format(fullEndDate);

      return "${outputDateStart.toString()} - ${outputDateEnd.toString()}";
    }

    // var localDate = time.toLocal();
    // var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    // var inputDate = inputFormat.parse(localDate.toString());

    // var outputFormat = DateFormat('HH:mm');
    // var outputDate = outputFormat.format(inputDate);
    // return outputDate.toString();
  }

  String _getFormattedDates(DateTime time) {
    var localDate = time.toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    if (time.isToday()) {
      var outputFormat = DateFormat('HH:mm');
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    } else {
      var outputFormat = DateFormat('EEE, d MMM HH:mm');
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    }
  }

  String _getStartEndDates() {
    if (classItem != null) {
      // TimeOfDay startTime = toTimeOfDay(classItem!.startTime);
      // TimeOfDay endTime = toTimeOfDay(classItem!.endTime);

      if (classItem!.occurs == "once") {
        var fullStartDate = DateTime(
            classItem!.getFormattedStartingDate().year,
            classItem!.getFormattedStartingDate().month,
            classItem!.getFormattedStartingDate().day,
            DateTime.now().hour,
            DateTime.now().minute);

        var outputFormat = DateFormat('EEE, d MMM');
        var outputDate = outputFormat.format(fullStartDate);
        return outputDate.toString();
      } else if (classItem!.occurs == 'repeating' ||
          classItem!.occurs == 'rotational') {
        //var allDays = classItem!.days!;
        // for (var i = 0; i < allDays.length; i++) {
        //   var day = allDays[i];
        //   day.toTitleCase();
        //   print("ASDADADADDA $day");
        //   allDays[i] = day;
        // }
        var stringList = classItem!.days!.join(", ").toTitleCase();

        return stringList;
      } else {
        return "";
      }
    } else if (eventItem != null) {
      if (eventItem!.occurs == "once") {
        var fullStartDate = DateTime(
            eventItem!.getFormattedStartingDate().year,
            eventItem!.getFormattedStartingDate().month,
            eventItem!.getFormattedStartingDate().day,
            DateTime.now().hour,
            DateTime.now().minute);

        var outputFormat = DateFormat('EEE, d MMM');
        var outputDate = outputFormat.format(fullStartDate);
        return outputDate.toString();
      } else if (eventItem!.occurs == 'repeating' ||
          eventItem!.occurs == 'rotational') {
        var stringList = eventItem!.days!.join(", ").toTitleCase();

        return stringList;
      } else {
        return "";
      }
    } else {
      return "";
    }
  }

  TimeOfDay toTimeOfDay(String? time) {
    if (time != null && time.isNotEmpty) {
      List<String> timeSplit = time.split(":");
      int hour = int.parse(timeSplit.first);
      int minute = int.parse(timeSplit[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } else {
      return TimeOfDay.now();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Card(
      margin: const EdgeInsets.only(top: 6, bottom: 6, right: 20, left: 20),
      color: theme == ThemeMode.light
          ? Colors.white
          : Constants.darkThemeSecondaryBackgroundColor,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: _cardTapped,
        child: Container(
          height: 132,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 18, top: 18, bottom: 18, right: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventItem == null
                          ? classItem?.subject?.subjectName ?? "".toUpperCase()
                          : eventItem?.subject?.subjectName ?? "".toUpperCase(),
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'BebasNeue',
                          fontWeight: FontWeight.normal,
                          color: eventItem == null
                              ? classItem?.subject?.colorHex != null
                                  ? HexColor.fromHex(
                                      classItem!.subject!.colorHex!)
                                  : Colors.red
                              : eventItem?.subject?.colorHex != null
                                  ? HexColor.fromHex(
                                      eventItem!.subject!.colorHex!)
                                  : Colors.red),
                    ),
                    Expanded(
                      child: Text(
                        eventItem == null
                            ? classItem?.module ?? ""
                            : eventItem?.module ?? "",
                        maxLines: 4,
                        style: theme == ThemeMode.light
                            ? Constants.socialLoginLightButtonTextStyle
                            : Constants.socialLoginDarkButtonTextStyle,
                      ),
                    ),
                    Text(
                      // eventItem == null ?
                      // '${_getFormattedTime(classItem.startDate)} - ${_getFormattedTime(classItem.dateTo)}',
                      _getFormattedTime(),
                      style: theme == ThemeMode.light
                          ? Constants.lightTHemeClassDateTextStyle
                          : Constants.darkTHemeClassDateTextStyle,
                    ),
                    Container(
                      height: 4,
                    ),
                    Text(
                      // eventItem == null ?
                      // '${_getFormattedTime(classItem.startDate)} - ${_getFormattedTime(classItem.dateTo)}',
                      _getStartEndDates(),
                      style: theme == ThemeMode.light
                          ? TextStyle(
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              color: Colors.black.withOpacity(0.7))
                          : TextStyle(
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              color: Colors.white.withOpacity(0.7)),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: Container(
                  margin: EdgeInsets.all(0),
                  height: 132,
                  width: 143,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Image border
                    child: Image.network(
                      fit: BoxFit.fill,
                      eventItem == null
                          ? classItem?.subject?.imageUrl ?? ""
                          : eventItem?.subject?.imageUrl ?? "",
                      height: 114,
                      width: 143,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 45,
                bottom: 0,
                top: 0,
                child: Container(
                  height: 132.0,
                  width: 98,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: FractionalOffset.centerRight,
                      end: FractionalOffset.centerLeft,
                      colors: theme == ThemeMode.light
                          ? [Colors.white.withOpacity(0.0), Colors.white]
                          : [
                              Constants.darkThemeSecondaryBackgroundColor
                                  .withOpacity(0.0),
                              Constants.darkThemeSecondaryBackgroundColor
                            ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
              ),
              if (classItem != null) ...[
                if (classItem!.upNext != null) ...[
                  if (classItem!.upNext == true) ...[
                    // Up Next banner
                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: theme == ThemeMode.light
                              ? Constants.lightThemeUpNextBannerBackgroundColor
                              : Constants.darkThemeUpNextBannerBackgroundColor,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0)),
                        ),
                        width: 83,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: 6, right: 6, top: 6, bottom: 6),
                        child: Text(
                          "Up Next",
                          style: theme == ThemeMode.light
                              ? Constants.lightThemeUpNextBannerTextStyle
                              : Constants.darkThemeUpNextBannerTextStyle,
                        ),
                      ),
                    )
                  ],
                ],
                if (classItem!.tasks != null) ...[
                  if (classItem!.tasks!.isNotEmpty) ...[
                    // Add Tasks Due banner
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: Container(
                        margin: EdgeInsets.only(right: 8, bottom: 8),
                        height: 24,
                        decoration: BoxDecoration(
                          color: Constants.taskDueBannerColor,
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        width: 83,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                            left: 6, right: 6, top: 6, bottom: 6),
                        child: Text(
                          "Task Due",
                          //"${classItem.tasksDue} Task Due",
                          style: Constants.taskDueBannerTextStyle,
                        ),
                      ),
                    )
                  ],
                ],
              ]
            ],
          ),
        ),
      ),
    );
  }
}
