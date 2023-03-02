import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';

import '../../app.dart';
import '.././Models/class_datasource.dart';
import '../Home_Screens/class_details_screen.dart';
import '../Widgets/ClassWidgets/class_widget.dart';
import '.././Widgets/exam_widget.dart';
import '../Models/exam_datasource.dart';
import '../Home_Screens/exam_details_screen.dart';
import './custom_segmentedcontrol.dart';
import '../Widgets/expandable_listview.dart';
import '../Activities_Screens/tasks_current.dart';
import '../Activities_Screens/tasks_past.dart';
import '../Activities_Screens/tasks_overdue.dart';

class ActivitiesTasksScreen extends StatefulWidget {
  const ActivitiesTasksScreen({super.key});

  @override
  State<ActivitiesTasksScreen> createState() => _ActivitiesTasksScreenState();
}

class _ActivitiesTasksScreenState extends State<ActivitiesTasksScreen> {
  final List<ClassSubject> _durations = ClassSubject.subjects;
  String selectedSubject = ClassSubject.subjects.first.title;
  final List<ExamStatic> _exams = ExamStatic.exams;
  int selectedTabIndex = 1;

  void _selectedExamCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ExamDetailsScreen(),
            fullscreenDialog: true));
  }

  void _selectedTabWithIndex(int index) {
    setState(() {
      selectedTabIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return Stack(
        children: [
          Container(
            height: 45,
            //width: double.infinity,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
            child: CustomSegmentedControl(
              _selectedTabWithIndex,
              tabs: {
                1: Text(
                  'Current (3)',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
                2: Text(
                  'Past (4)',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
                3: Text(
                  'Overdue (12)',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
              },
            ),
          ),

          Container(
            height: 45,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 75),
            decoration: BoxDecoration(
              color:
                  theme == ThemeMode.light ? Colors.transparent : Colors.black,
              border: Border.all(
                width: 1,
                color: theme == ThemeMode.dark
                    ? Colors.transparent
                    : Colors.black.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  value: selectedSubject,
                  onChanged: (String? newValue) =>
                      setState(() => selectedSubject = newValue ?? ""),
                  items: _durations
                      .map<DropdownMenuItem<String>>(
                          (ClassSubject durationItem) =>
                              DropdownMenuItem<String>(
                                value: durationItem.title,
                                child: Text(durationItem.title),
                              ))
                      .toList(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ),
          ),
          // Check which tab is selected
          if (selectedTabIndex == 1) ...[
            TasksCurrentList(),
          ],
          if (selectedTabIndex == 2) ...[
            TasksPastList(),
          ],
          if (selectedTabIndex == 3) ...[
            TasksOverdueList(),
          ]
        ],
      );
    });
  }
}
