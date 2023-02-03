import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';
import '../tag_card.dart';
import '../../Models/subjects_datasource.dart';

class ClassRepetition extends StatefulWidget {
  final Function subjectSelected;
  ClassRepetition({super.key, required this.subjectSelected});

  @override
  State<ClassRepetition> createState() => _ClassRepetitionState();
}

class _ClassRepetitionState extends State<ClassRepetition> {
  final List<ClassTagItem> _repetitions = ClassTagItem.repetitionModes;

  int selectedTabIndex = 0;

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      for (var item in _repetitions) {
        item.selected = false;
      }

      _repetitions[index].selected = true;
      widget.subjectSelected(_repetitions[index]);
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
              'Occurs*',
              style: theme == ThemeMode.light ? Constants.lightThemeSubtitleTextStyle : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 14,
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: _repetitions
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
