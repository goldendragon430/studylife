import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';
import '../regular_teztField.dart';
import '../../app.dart';
import '../../Models/subjects_datasource.dart';

class ClassTextImputs extends StatefulWidget {
  final Function subjectSelected;
  ClassTextImputs({super.key, required this.subjectSelected});

  @override
  State<ClassTextImputs> createState() => _ClassTextImputsState();
}

class _ClassTextImputsState extends State<ClassTextImputs> {
  final moduleNameController = TextEditingController();
  final roomNameController = TextEditingController();
  final buildingNameController = TextEditingController();
  final teacherNameController = TextEditingController();

  final List<ClassTagItem> _subjects = ClassTagItem.subjectModes;

  int selectedTabIndex = 0;

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      for (var item in _subjects) {
        item.selected = false;
      }

      _subjects[index].selected = true;
      widget.subjectSelected(_subjects[index]);
      print("CARD SELECTED $index");
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
              'Module',
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 14,
            ),
            RegularTextField("Module Name", (value) {
              FocusScope.of(context).unfocus();
            }, TextInputType.emailAddress, moduleNameController,
                theme == ThemeMode.dark),
            Container(
              height: 14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Room',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 14,
                      ),
                      RegularTextField("Room", (value) {
                        FocusScope.of(context).unfocus();
                      }, TextInputType.emailAddress, roomNameController,
                          theme == ThemeMode.dark),
                    ],
                  ),
                ),
                Container(
                   height: 90,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Building',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 14,
                      ),
                      RegularTextField("Building", (value) {
                        FocusScope.of(context).unfocus();
                      }, TextInputType.emailAddress, buildingNameController,
                          theme == ThemeMode.dark),
                    ],
                  ),
                ),
              ],
            ),
               Text(
              'Teacher Name',
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 14,
            ),
            RegularTextField("Teacher Name", (value) {
              FocusScope.of(context).unfocus();
            }, TextInputType.emailAddress, teacherNameController,
                theme == ThemeMode.dark),
            Container(
              height: 14,
            ),
          ],
        ),
      );
    });
  }
}
