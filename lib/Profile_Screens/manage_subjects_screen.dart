import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../Utilities/constants.dart';
import '../Models/subjects_datasource.dart';
import '../Widgets/rounded_elevated_button.dart';
import '../Widgets/ProfileWidgets/manage_subject_card.dart';
import './new_subject_screen.dart';

class ManageSubjectsScreen extends StatefulWidget {
  const ManageSubjectsScreen({super.key});

  @override
  State<ManageSubjectsScreen> createState() => _ManageSubjectsScreenState();
}

class _ManageSubjectsScreenState extends State<ManageSubjectsScreen> {
  final List<SubjectListItem> _items = SubjectListItem.subjectsList;

  void _addSubjectTapped() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const AddSubjectScreen(),
            fullscreenDialog: true));
  }

  void _subjectCardSelected(int index) {
    print("Selected subject card with Index: $index");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Scaffold(
        backgroundColor: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(
            "Manage Subjects",
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: theme == ThemeMode.light ? Colors.black : Colors.white),
          ),
        ),
        body: Container(
          height: double.infinity,
          margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
          child: Stack(
            children: [
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 8),
                child: RoundedElevatedButton(
                    _addSubjectTapped,
                    "+ Add new subject",
                    Constants.lightThemePrimaryColor,
                    Colors.black,
                    50),
              ),
              Container(
                //height: double.infinity,
                margin: EdgeInsets.only(top: 76),

                child: ListView.builder(
                  // controller: widget._controller,
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return ManageSubjectCard(
                        subjectItem: _items[index],
                        cardIndex: index,
                        cardselected: _subjectCardSelected);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
