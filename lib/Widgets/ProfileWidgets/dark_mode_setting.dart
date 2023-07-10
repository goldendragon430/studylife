import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';
import '../tag_card.dart';
import '../../Models/subjects_datasource.dart';

class DarkModeSettingh extends StatefulWidget {
  final Function daySelected;
  final int selectedIndex;
  final List<ClassTagItem> modes;
  const DarkModeSettingh(
      {super.key,
      required this.daySelected,
      required this.selectedIndex,
      required this.modes});

  @override
  State<DarkModeSettingh> createState() => _DarkModeSettinghState();
}

class _DarkModeSettinghState extends State<DarkModeSettingh> {
   List<ClassTagItem> _modes = [];

  @override
  void initState() {
    _modes = widget.modes;

    super.initState();
  }

  void _selectTab(int index) {
    setState(() {
      for (var item in _modes) {
        item.selected = false;
      }

      _modes[index].selected = true;
      widget.daySelected(_modes[index]);
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
              'Dark Mode',
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
                children: _modes
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
