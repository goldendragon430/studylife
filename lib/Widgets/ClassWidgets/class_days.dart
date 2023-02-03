import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';
import '../tag_card.dart';
import '../../Models/subjects_datasource.dart';

class ClassWeekDays extends StatefulWidget {
  final Function subjectSelected;
  ClassWeekDays({super.key, required this.subjectSelected});

  @override
  State<ClassWeekDays> createState() => _ClassWeekDaysState();
}

class _ClassWeekDaysState extends State<ClassWeekDays> {
  final List<ClassTagItem> _days = ClassTagItem.classDays;


  void _selectTab(int index) {
    setState(() {
      // for (var item in _repetitions) {
      //   item.selected = false;
      // }

      _days[index].selected = true;
      widget.subjectSelected(_days);
      print("CARD SELECTED $index");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        // Tag items
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Days*',
              style: theme == ThemeMode.light ? Constants.lightThemeSubtitleTextStyle : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 14,
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: _days
                  .mapIndexed((e, i) => TagCard(
                        title: e.title,
                        selected: e.selected,
                        cardIndex: e.cardIndex,
                        cardselected: _selectTab,
                        isAddNewCard: e.isAddNewCard,
                      ))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}
