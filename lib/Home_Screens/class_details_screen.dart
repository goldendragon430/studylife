import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';

import '../../app.dart';
import '../Widgets/class_exam_details_info_card.dart';
import '../Widgets/icon_label_details_row.dart';
import '../Models/tasks_due_dataSource.dart';
import '../Widgets/task_due_card.dart';
import '../Widgets/custom_alert.dart';

class ClassDetailsScreen extends ConsumerWidget {
  const ClassDetailsScreen({super.key});

  void _editButtonPressed(BuildContext context) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => const CustomAlertView(),
      //       fullscreenDialog: true));
  }

  void _closeButtonPressed(context) {
    Navigator.pop(context);
  }

  void _selectTaskDue(int index) {
    print("CARD SELECTED $index");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    final List<TaskDueStatic> _tasksDue = TaskDueStatic.tasksDue;

    return Container(
      color: theme == ThemeMode.light
          ? Constants.lightThemeClassExamDetailsBackgroundColor
          : Constants.darkThemeBackgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 206,
            alignment: Alignment.topCenter,
            child: Image.asset("assets/images/ClassExamBackgroundImage.png"),
          ),
          Container(
            height: 36,
            width: 75,
            margin: const EdgeInsets.only(left: 20, top: 50),
            child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    )),
                    minimumSize:
                        MaterialStateProperty.all(const Size((75), 45)),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(const TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
                onPressed: () => _editButtonPressed(context),
                child: Text("Edit")),
          ),
          Positioned(
            right: -10,
            top: 45,
            child: MaterialButton(
              splashColor: Colors.transparent,
              elevation: 0.0,
              // ),
              onPressed: () => _closeButtonPressed(context),
              child: Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/CloseButtonX.png'),
                        fit: BoxFit.fill)),
              ),
            ),
          ),
          ClassExamDetailsInfoCard(Colors.red, "Class", "Chemistry",
              "Redox Reactions", DateTime.now(), DateTime.now()),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 349),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconLabelDetailsRow(
                    Image.asset("assets/images/LocationPinGrey.png"),
                    "Where",
                    "Room 5, Block D"),
                Container(
                  height: 8,
                ),
                IconLabelDetailsRow(
                    Image.asset("assets/images/ProfessorIconGrey.png"),
                    "Professor",
                    "Mark Anderson"),
                Container(
                  height: 58,
                ),
                Text(
                  'Tasks due for Chemistry',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextStyle,
                ),
              ],
            ),
          ),
            Container(
                  alignment: Alignment.topCenter,
                  height: double.infinity,
                  margin: const EdgeInsets.only(top: 483),
                  child: ListView.builder(
                     // controller: widget._controller,
                      itemCount: _tasksDue.length,
                      itemBuilder: (context, index) {
                        return TaskDueCardForClassOrExam(
                            index,
                            _tasksDue[index],
                            _selectTaskDue,);
                      }),
                ),
        ],
      ),
    );
  }
}
