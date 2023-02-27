import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:intl/intl.dart';

import '../../app.dart';
import '../../Models/class_datasource.dart';
import '../../Utilities/constants.dart';

class ClassWidget extends ConsumerWidget {
  final int cardIndex;
  final bool upNext;

  final ClassStatic classItem;
  final Function cardselected;

  const ClassWidget(
      {super.key,
      required this.classItem,
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
          height: 114,
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
                      classItem.title.toUpperCase(),
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'BebasNeue',
                          fontWeight: FontWeight.normal,
                          color: classItem.subjectColor),
                    ),
                    Expanded(
                      child: Text(
                        classItem.description,
                        maxLines: 4,
                        style: theme == ThemeMode.light
                            ? Constants.socialLoginLightButtonTextStyle
                            : Constants.socialLoginDarkButtonTextStyle,
                      ),
                    ),
                    Text(
                      '${_getFormattedTime(classItem.dateFrom)} - ${_getFormattedTime(classItem.dateTo)}',
                      style: theme == ThemeMode.light
                          ? Constants.lightTHemeClassDateTextStyle
                          : Constants.DarkTHemeClassDateTextStyle,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  child: Image.asset(
                    classItem.subjectImage,
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
              if (classItem.upNext) ...[
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
                    padding:
                        EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                    child: Text(
                      "Up Next",
                      style: theme == ThemeMode.light
                          ? Constants.lightThemeUpNextBannerTextStyle
                          : Constants.darkThemeUpNextBannerTextStyle,
                    ),
                  ),
                )
              ],
              if (classItem.tasksDue != 0) ...[
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
                      "${classItem.tasksDue} Task Due",
                      style: Constants.taskDueBannerTextStyle,
                    ),
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
