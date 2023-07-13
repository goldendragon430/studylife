import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';
import '../tag_card.dart';
import '../../Models/subjects_datasource.dart';

class NumberOfWeeks extends StatefulWidget {
  final Function daySelected;
  const NumberOfWeeks({super.key, required this.daySelected});

  @override
  State<NumberOfWeeks> createState() => _NumberOfWeeksState();
}

class _NumberOfWeeksState extends State<NumberOfWeeks> {
  final List<ClassTagItem> _days = ClassTagItem.settingsWeeksToDisplay;

  void _selectTab(int index) {
    setState(() {
      for (var item in _days) {
        item.selected = false;
      }

      _days[index].selected = true;
      widget.daySelected(_days[index]);
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
              'Number of weeks',
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 14,
            ),
            Container(
              height: 44,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
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
            ),
          ],
        ),
      );
    });
  }
}
