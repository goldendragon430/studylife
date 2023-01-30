import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:intl/intl.dart';

import '../app.dart';
import '../Utilities/constants.dart';
import '../Models/exam_datasource.dart';

class ExamWidget extends ConsumerWidget {
  final int cardIndex;
  final bool upNext;

  final ExamStatic classItem;
  final Function cardselected;

  const ExamWidget(
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
          height: 142,
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
                      '${_getFormattedTime(classItem.dateFrom)}',
                      style: theme == ThemeMode.light
                          ? Constants.lightTHemeClassDateTextStyle
                          : Constants.DarkTHemeClassDateTextStyle,
                    ),
                      Text(
                      '${classItem.duration.abs().inMinutes} Minutes - ${classItem.examType}',
                      style: theme == ThemeMode.light
                          ? Constants.socialLoginLightButtonTextStyle
                          : Constants.socialLoginDarkButtonTextStyle,
                    ),
                  ],
                ),
              ),
              Container(
                // Subject Image
                margin: const EdgeInsets.only(left: 192),
                alignment: Alignment.bottomRight,
                child: classItem.subjectImage,
              ),
              Container(
                // Gradient Color filler
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(left: 192),
                width: 98,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.centerLeft,
                        stops: const [
                      0.1,
                      0.9,
                    ],
                        colors: [
                      theme == ThemeMode.light
                          ? Colors.white.withOpacity(.1)
                          : Constants.darkThemeSecondaryBackgroundColor
                              .withOpacity(.8),
                           Colors.white,

                    ])),
              ),
       
      
            ],
          ),
        ),
        // child: Container(
        //   height: 126,
        //   padding: const EdgeInsets.only(left: 17, right: 17),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       badgeNumber.toString(),
        //       style: Constants.tabItemBadgeTextStyle,
        //     ),
        //     Text(
        //       " ",
        //       style: Constants.tabItemBadgeTextStyle,
        //     ),
        //     Text(
        //       title,
        //       style: Constants.tabItemTitleTextStyle,
        //     ),
        //   ],
        // ),
      ),
    );
  }
}