import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';
import '../tag_card.dart';
import '../../Models/subjects_datasource.dart';

class SelectFirstDay extends StatefulWidget {
  final Function subjectSelected;
  final List<ClassTagItem> days;
  const SelectFirstDay({super.key, required this.subjectSelected, required this.days});

  @override
  State<SelectFirstDay> createState() => _SelectFirstDayState();
}

class _SelectFirstDayState extends State<SelectFirstDay> {

  @override
  void initState() {
    //  for (var item in widget.days) {
    //   }
    super.initState();
  }


  void _selectTab(int index) {
    setState(() {
      for (var item in widget.days) {
        item.selected = false;
      }

      widget.days[index].selected = true;
      widget.subjectSelected(widget.days[index]);
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
              'First Day',
              style: theme == ThemeMode.light ? Constants.lightThemeSubtitleTextStyle : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 14,
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: widget.days
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
