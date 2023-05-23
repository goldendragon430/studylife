import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '../Models/API/task.dart';
import '../../app.dart';

class TaskDetailsInfoCard extends ConsumerWidget {
  final Task taskitem;
  const TaskDetailsInfoCard(this.taskitem, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    return Container(
      height: 220,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 175),
      decoration: const BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.center,
        //   stops: const [
        //     0.1,
        //     0.9,
        //   ],
        //   colors: [
        //     mainGradientColor,
        //     theme == ThemeMode.light
        //         ? Colors.white
        //         : Constants.darkThemeClassExamCardBackgroundColor,
        //   ],
        // ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: 180,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  // Type
                  right: 0,
                  top: 25,
                  child: Container(
                    height: 25,
                    width: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        bottomLeft: Radius.circular(4.0),
                      ),
                      color: Constants.blueButtonBackgroundColor,
                    ),
                    child: Text(
                      taskitem.type ?? "",
                      style: Constants.roboto15NormalWhiteTextStyle,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Title
                      Text(
                        taskitem.subject?.subjectName ?? "",
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: taskitem.subject?.colorHex != null
                              ? HexColor.fromHex(taskitem.subject!.colorHex!)
                              : Colors.red,
                        ),
                      ),
                      // Theme
                      Text(
                        taskitem.category ?? "",
                        style: theme == ThemeMode.light
                            ? Constants.tabItemTitleTextStyle
                            : Constants.darkThemeInfoSubtitleTextStyle,
                      ),
                      Container(
                        height: 20,
                      ),
                      Text(
                        "".getFormattedDateClass(taskitem.dueDate ?? ""),
                        //dateFrom.getFormattedDate(dateFrom),
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeDetailsDateStyle
                            : Constants.darkThemeDetailsDateStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
