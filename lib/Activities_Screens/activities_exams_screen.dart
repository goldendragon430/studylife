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

class ActivitiesExamsScreen extends StatefulWidget {
  const ActivitiesExamsScreen({super.key});

  @override
  State<ActivitiesExamsScreen> createState() => _ActivitiesExamsScreenState();
}

class _ActivitiesExamsScreenState extends State<ActivitiesExamsScreen> {
   final ScrollController scrollcontroller = ScrollController();
  final List<ClassSubject> _durations = ClassSubject.subjects;
  String selectedSubject = ClassSubject.subjects.first.title;
  final List<ExamStatic> _exams = ExamStatic.exams;
  int selectedTabIndex = 0;

  void _selectedTabWithIndex(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  void _selectedExamCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ExamDetailsScreen(),
            fullscreenDialog: true));
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
                  'Current',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
                2: Text(
                  'Past',
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
          // Exams
          Container(
            alignment: Alignment.topCenter,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 186),
            child: ListView.builder(
             // controller: scrollcontroller,
              itemBuilder: (BuildContext context, int index) {
                return ExpandableListView(
                  period: "Earlier This Month - Mar 2022",
                  numberOfItems: '10',
                  exams: _exams,
                );
              },
              itemCount: 5,
            ),
            // child: ListView.builder(
            //     // controller: widget._controller,
            //     itemCount: _exams.length,
            //     itemBuilder: (context, index) {
            //       return ExamWidget(
            //           classItem: _exams[index],
            //           cardIndex: index,
            //           upNext: true,
            //           cardselected: _selectedExamCard);
            //     }),
          ),
        ],
      );
    });
  }
}
