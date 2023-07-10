import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Widgets/loaderIndicator.dart';

import '../app.dart';
import '../Utilities/constants.dart';
import '../Widgets/regular_teztField.dart';
import '../Widgets/ClassWidgets/class_text_imputs.dart';
import '../Widgets/exam_widget.dart';
import '../Widgets/TaskWidgets/task_widget.dart';
import './class_details_screen.dart';
import './exam_details_screen.dart';
import 'package:my_study_life_flutter/Widgets/ClassWidgets/class_widget.dart';
import '../Widgets/ExtrasWidgets/extras_widget.dart';
import '../Widgets/HolidayWidgets/holiday_widget.dart';

import '../Activities_Screens/holiday_xtra_detail_screen.dart';

import '../Models/API/holiday.dart';
import '../Widgets/custom_snack_bar.dart';
import '../Models/API/classmodel.dart';
import '../Models/API/exam.dart';
import '../Models/API/task.dart';
import '../Models/user.model.dart';
import '../Models/API/event.dart';

class SearchPage extends ConsumerWidget {
  SearchPage({super.key});
  final searchController = TextEditingController();

  void _submitForm(String text, TextFieldType type) {
    if (text.length >= 3) {
      print("EO GA $text");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: theme == ThemeMode.light
              ? Constants.lightThemePrimaryColor
              : Colors.white,
          elevation: 0.0,
          title: Container(
              width: double.infinity,
              height: 53,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: RegularTextField(
                  "Search...",
                  (value) {
                    _submitForm(
                        searchController.text, TextFieldType.moduleName);
                    // FocusScope.of(context).nextFocus();
                  },
                  TextInputType.emailAddress,
                  searchController,
                  theme == ThemeMode.dark,
                  autofocus: true,
                ),
              )),
        ),
      ),
    );
  }
}
