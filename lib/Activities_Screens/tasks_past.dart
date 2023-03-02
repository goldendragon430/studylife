import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../../app.dart';
import "package:collection/collection.dart";
import 'package:group_list_view/group_list_view.dart';
import '../Widgets/expandable_listview.dart';

import '../Models/task_datasource.dart';
import '../Extensions/extensions.dart';
import '../Widgets/TaskWidgets/task_widget.dart';

class TasksPastList extends ConsumerWidget {
  TasksPastList({super.key});
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
      child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ExpandableListView(
                  period: "Earlier This Month - Mar 2022",
                  numberOfItems: '10',
                  tasks: _tasks,
                );
              },
              itemCount: 5,
            ),
    );
  }
}
