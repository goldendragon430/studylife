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

class TasksOverdueList extends ConsumerWidget {
  TasksOverdueList({super.key});
  final ScrollController scrollcontroller = ScrollController();
  final List<TaskItem> _tasks = TaskItem.overdueTasks;

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

    return Container(
      margin: const EdgeInsets.only(top: 164),
      child: ListView.builder(
          // controller: widget._controller,
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (index == 0) ...[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      'Overdue (${_tasks.length})',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: Constants.taskDueBannerColor),
                    ),
                  ),
                ],
                TaskWidget(
                    taskItem: _tasks[index],
                    cardIndex: index,
                    upNext: true,
                    cardselected: _selectedCard),
              ],
            );
          }),
    );
  }
}
