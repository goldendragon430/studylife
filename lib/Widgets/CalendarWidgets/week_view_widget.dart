import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app.dart';
import '../../Models/event.dart';
import '../../Utilities/constants.dart';

class WeekViewWidget extends StatefulWidget {
  final GlobalKey<WeekViewState>? state;
  final double? width;

  const WeekViewWidget({Key? key, this.state, this.width}) : super(key: key);

  @override
  State<WeekViewWidget> createState() => _WeekViewWidgetState();
}

class _WeekViewWidgetState extends State<WeekViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return WeekView<Event>(
        key: widget.state,
        width: widget.width,
        heightPerMinute: 1.9,
        liveTimeIndicatorSettings: HourIndicatorSettings.none(),
        weekPageHeaderBuilder: (startDate, endDate) {
          return Container();
        },
        weekDayBuilder: (date) {
          final weekDay = DateFormat('EEE').format(date);

          return Container(
            child: Center(
              child: Text(
                weekDay,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    color: Constants.dayCalendarHourColor),
              ),
            ),
          );
        },
        weekNumberBuilder: (firstDayOfWeek) {
          return Container();
        },
        timeLineBuilder: (date) {
          final hour = DateFormat('HH:mm').format(date);
          return Container(
            color: theme == ThemeMode.light
                ? Colors.white
                : Constants.weekCalendarNormalDayDarkBackround,
            alignment: Alignment.topCenter,
            height: 100,
            child: Text(
              hour,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                  color: Constants.dayCalendarHourColor),
            ),
          );
        },
        weekDetectorBuilder: (
            {required date,
            required height,
            required heightPerMinute,
            required minuteSlotSize,
            required width}) {
          final weekday = date.day;
          Color backgroundColor;

          switch (weekday) {
            case 1:
            case 3:
            case 5:
            case 7:
              backgroundColor = theme == ThemeMode.light
                  ? Constants.weekCalendarOddDayLightBackround
                  : Constants.weekCalendarOddDayDarkBackround;
              break;
            case 2:
            case 4:
            case 6:
              backgroundColor = theme == ThemeMode.light
                  ? Constants.weekCalendarNormalDayLightBackround
                  : Constants.weekCalendarNormalDayDarkBackround;
              break;
            default:
              backgroundColor = Colors.transparent;
          }

          return Container(color: backgroundColor);
        },
      );
    });
  }
}


// class WeekViewWidget extends StatelessWidget {
//   final GlobalKey<WeekViewState>? state;
//   final double? width;

//   const WeekViewWidget({Key? key, this.state, this.width}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return WeekView<Event>(
//       key: state,
//       width: width,
//     );
//   }
// }
