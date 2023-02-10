import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../regular_teztField.dart';
import '../../app.dart';
import '../multiline_textField.dart';

class HolidayTextImputs extends StatefulWidget {
  final Function formsFilled;
  final String labelTitle;
  final String hintText;
  const HolidayTextImputs(
      {super.key, required this.formsFilled, required this.labelTitle, required this.hintText});

  @override
  State<HolidayTextImputs> createState() => _HolidayTextImputsState();
}

class _HolidayTextImputsState extends State<HolidayTextImputs> {
  final titleController = TextEditingController();

  void _holidayFormSubmitted(String text) {}

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
              widget.labelTitle,
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 6,
            ),
            RegularTextField(widget.hintText, (value) {
              FocusScope.of(context).unfocus();
            }, TextInputType.emailAddress, titleController,
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
