import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:intl/intl.dart';

import '../../app.dart';
import '../../Models/holidays_datasource.dart';
import '../../Utilities/constants.dart';

class HolidayWidget extends ConsumerWidget {
  final int cardIndex;
  final bool upNext;

  final HolidayItem holidayItem;
  final Function cardselected;

  const HolidayWidget(
      {super.key,
      required this.holidayItem,
      required this.cardIndex,
      required this.upNext,
      required this.cardselected});

  void _cardTapped() {
    cardselected(cardIndex);
  }

  String _getFormattedTime(DateTime time) {
    var localDate = time.toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    if (time.isToday()) {
      var outputFormat = DateFormat('HH:mm');
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    } else {
      var outputFormat = DateFormat('EEE, d MMM ');
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
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
          height: holidayItem.holidayImage != null ? 103 : 73,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 18, top: 18, bottom: 18, right: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        holidayItem.title,
                        maxLines: 4,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light
                                ? Constants.lightThemeTextSelectionColor
                                : Colors.white),
                      ),
                    ),
                    Text(
                      holidayItem.dateTo != null
                          ? '${_getFormattedTime(holidayItem.dateFrom)} - ${_getFormattedTime(holidayItem.dateTo ?? DateTime.now())}'
                          : _getFormattedTime(holidayItem.dateFrom),
                      style: theme == ThemeMode.light
                          ? Constants.lightTHemeClassDateTextStyle
                          : Constants.DarkTHemeClassDateTextStyle,
                    ),
                  ],
                ),
              ),
              if (holidayItem.holidayImage != null) ...[
                Positioned(
                  right: 0,
                  child: Container(
                    height: 141,
                    width: 143,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset(
                        holidayItem.holidayImage ?? "",
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 45,
                  child: Container(
                    height: 114.0,
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
              ],
            ],
          ),
        ),
      ),
    );
  }
}
