import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import 'select_subject.dart';
import '../../Models/subjects_datasource.dart';
import './select_class_mode.dart';
import './class_text_imputs.dart';

class CreateClass extends StatefulWidget {
  const CreateClass({super.key});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  final ScrollController scrollcontroller = ScrollController();

  void _subjectSelected(ClassTagItem subject) {
    print("Selected subject: ${subject.title}");
  }

  void _subjectModeSelected(ClassTagItem subject) {
    print("Selected subject: ${subject.title}");
  }

    void _TextInputAdded(String input) {
    print("Selected subject: ${input}");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        color: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        child: ListView.builder(
            controller: scrollcontroller,
            padding: const EdgeInsets.only(top: 30),
            itemCount: 3,
            itemBuilder: (context, index) {
              if (index == 10) {
                // Save/Cancel Buttons
                return Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 32),
                  // child: RoundedElevatedButton(
                  //     getAllTextInputs, widget.saveButtonTitle, 28),
                );
              } else {
                // Add Questions
                return Column(
                  children: [
                    if (index == 0) ...[
                      // Select Subject
                      SelectSubject(
                        subjectSelected: _subjectSelected,
                      )
                    ],
                    Container(
                      height: 14,
                    ),
                    if (index == 1) ...[
                      // Select Subject
                      SelectClassMode(
                        subjectSelected: _subjectModeSelected,
                      )
                    ],
                    if (index == 2) ...[
                      // Select Subject
                      ClassTextImputs(
                        subjectSelected: _subjectModeSelected,
                      )
                    ]
                  ],
                );
              }
            }),
      );
    });
  }
}
