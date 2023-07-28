import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';
import '../tag_card.dart';
import '../../Models/subjects_datasource.dart';

class SelectTaskType extends StatefulWidget {
  final Function taskSelected;
  final String? preselectedType;
  SelectTaskType({super.key, required this.taskSelected, this.preselectedType});

  @override
  State<SelectTaskType> createState() => _SelectTaskTypeState();
}

class _SelectTaskTypeState extends State<SelectTaskType> {
  final List<ClassTagItem> _taskTypes = ClassTagItem.taskTypes;

  int selectedTabIndex = 0;

  @override
  void initState() {
    if (widget.preselectedType != null) {
      for (var i = 0; i < _taskTypes.length; i++) {
        var type = _taskTypes[i];
        if (type.title == widget.preselectedType) {
          type.selected = true;
          _taskTypes[i] = type;
        }
      }
    }
    // TODO: implement initState
    super.initState();
  }

  // @override
  //   void dispose() {

  //     }
  //   super.dispose();
  // }

  @override
  void dispose() {
    for (var i = 0; i < _taskTypes.length; i++) {
      var type = _taskTypes[i];
      type.selected = false;
      _taskTypes[i] = type;
    }
    super.dispose();
  }

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      for (var item in _taskTypes) {
        item.selected = false;
      }

      _taskTypes[index].selected = true;
      widget.taskSelected(_taskTypes[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        // Tag items
        // height: 34,
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Type*',
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 14,
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: _taskTypes
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
