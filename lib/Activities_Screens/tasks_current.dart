import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../../app.dart';
import "package:collection/collection.dart";
import 'package:group_list_view/group_list_view.dart';

import '../Models/task_datasource.dart';
import '../Extensions/extensions.dart';
import '../Widgets/TaskWidgets/task_widget.dart';
import '../Models/API/task.dart';

class TasksCurrentList extends ConsumerWidget {
  TasksCurrentList({super.key});
  final ScrollController scrollcontroller = ScrollController();
  final List<TaskItem> _tasks = TaskItem.thisMonthTasks;

  void _selectedCard(int index) {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => const ClassDetailsScreen(),
    //         fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    var groupByDate = groupBy(_tasks, (obj) => obj.date.isToday());

    return Container(
      margin: const EdgeInsets.only(top: 164),
      child: GroupListView(
        sectionsCount: groupByDate.keys.toList().length,
        countOfItemInSection: (int section) {
          return groupByDate.values.toList()[section].length;
        },
        itemBuilder: (BuildContext context, IndexPath index) {
          return TaskWidget(
              taskItem: Task(),
              cardIndex: index.index,
              upNext: true,
              cardselected: _selectedCard);
        },
        groupHeaderBuilder: (BuildContext context, int section) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: section == 0
                ? Text(
                    'Due Today (${groupByDate.values.toList()[section].length})',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: theme == ThemeMode.light
                          ? Colors.black.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                    ),
                  )
                : Text(
                    'Due This month (${groupByDate.values.toList()[section].length})',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: theme == ThemeMode.light
                          ? Colors.black.withOpacity(0.6)
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 10),
        sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),
      ),
    );
  }
}
