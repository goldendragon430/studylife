import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import './holiday_text_imputs.dart';
import '../ClassWidgets/select_dates.dart';
import '../add_photo_widget.dart';

class CreateHoliday extends StatefulWidget {
  const CreateHoliday({super.key});

  @override
  State<CreateHoliday> createState() => _CreateHolidayState();
}

class _CreateHolidayState extends State<CreateHoliday> {
  final ScrollController scrollcontroller = ScrollController();

  void _textInputAdded(String input) {
    print("Selected subject: ${input}");
  }

  void _selectedDates(DateTime timtimeFromeTo, DateTime timeTo) {
    //print("Selected repetitionMode: ${repetition.title}");
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
              return Column(
                children: [
                  if (index == 0) ...[
                    HolidayTextImputs(formsFilled: _textInputAdded, hintText: 'Holoiday Name', labelTitle: 'Name*',)
                  ],
                  if (index == 1) ...[
                    SelectDates(dateSelected: _selectedDates),
                  ],
                  if (index == 2) ...[
                    AddPhotoWidget()
                  ],
                ],
              );
            }),
      );
    });
  }
}
