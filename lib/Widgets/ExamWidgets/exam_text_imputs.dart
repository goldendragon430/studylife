import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../regular_teztField.dart';
import '../../app.dart';

class ExamTextImputs extends StatefulWidget {
  final Function subjectSelected;
  final bool isExamInPerson;
  const ExamTextImputs(
      {super.key, required this.subjectSelected, required this.isExamInPerson});

  @override
  State<ExamTextImputs> createState() => _ExamTextImputsState();
}

class _ExamTextImputsState extends State<ExamTextImputs> {
  final moduleNameController = TextEditingController();
  final roomNameController = TextEditingController();
  final seatNameController = TextEditingController();
  final onlineUrlController = TextEditingController();

  int selectedTabIndex = 0;

  void _selectTab(int index) {}

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
              height: 6,
            ),
            RegularTextField("Module Name", (value) {
              FocusScope.of(context).unfocus();
            }, TextInputType.emailAddress, moduleNameController,
                theme == ThemeMode.dark),
            Container(
              height: 14,
            ),
            if (widget.isExamInPerson) ...[
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
                          'Seat',
                          style: theme == ThemeMode.light
                              ? Constants.lightThemeSubtitleTextStyle
                              : Constants.darkThemeSubtitleTextStyle,
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          height: 6,
                        ),
                        RegularTextField("Seat #", (value) {
                          FocusScope.of(context).unfocus();
                        }, TextInputType.emailAddress, seatNameController,
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
                          'Room',
                          style: theme == ThemeMode.light
                              ? Constants.lightThemeSubtitleTextStyle
                              : Constants.darkThemeSubtitleTextStyle,
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          height: 6,
                        ),
                        RegularTextField("Room", (value) {
                          FocusScope.of(context).unfocus();
                        }, TextInputType.emailAddress, roomNameController,
                            theme == ThemeMode.dark),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            if (!widget.isExamInPerson) ...[
              Text(
                'Online URL',
                style: theme == ThemeMode.light
                    ? Constants.lightThemeSubtitleTextStyle
                    : Constants.darkThemeSubtitleTextStyle,
                textAlign: TextAlign.left,
              ),
              Container(
                height: 6,
              ),
              RegularTextField("Online URL", (value) {
                FocusScope.of(context).unfocus();
              }, TextInputType.emailAddress, onlineUrlController,
                  theme == ThemeMode.dark),
              Container(
                height: 14,
              ),
            ],
          ],
        ),
      );
    });
  }
}