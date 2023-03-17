import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:intl/intl.dart';

import '../../app.dart';
import '../../Models/subjects_datasource.dart';
import '../../Utilities/constants.dart';

class ManageSubjectCard extends ConsumerWidget {
  final int cardIndex;

  final SubjectListItem subjectItem;
  final Function cardselected;

  const ManageSubjectCard(
      {super.key,
      required this.subjectItem,
      required this.cardIndex,
      required this.cardselected});

  void _cardTapped() {
    cardselected(cardIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Card(
      margin: const EdgeInsets.only(top: 6, bottom: 6),
      color: theme == ThemeMode.light
          ? Colors.white
          : Constants.darkThemeSecondaryBackgroundColor,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: _cardTapped,
        child: Container(
          height: 126,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: Container(
                  height: 126.0,
                  child: 
                   ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        // clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          subjectItem.subjectImage,
                        ),
                      ),
                    ),
                ),
                
              ),
              Positioned(
                right: 60,
                child: Container(
                  height: 126.0,
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
              Container(
                height: double.infinity,
                margin: const EdgeInsets.only(
                    left: 18, top: 18, bottom: 18, right: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subjectItem.title.toUpperCase(),
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'BebasNeue',
                          fontWeight: FontWeight.normal,
                          color: subjectItem.subjectColor),
                    ),
                    Container(
                      //  margin: EdgeInsets.only(top: 10),
                      child: TextButton(
                        onPressed: () {
                          // Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        child: Text(
                          'Edit',
                          textAlign: TextAlign.left,
                          style: theme == ThemeMode.light
                              ? Constants.lightThemeNavigationButtonStyle
                              : Constants.darkThemeNavigationButtonStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}