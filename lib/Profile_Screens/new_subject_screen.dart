import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';

import '../../app.dart';
import '../Widgets/regular_teztField.dart';
import '../Models/subjectColors_dataosource.dart';
import '../Widgets/ProfileWidgets/select_color_card.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final subjectNameController = TextEditingController();

  List<SubjectColor> subjectColors = SubjectColor.subjectColors;

  void _selectedCard(int index) {
    setState(() {
      for (var savedColor in subjectColors) {
        savedColor.selected = false;
      }

      var color = subjectColors[index];
      color.selected = !color.selected;
      subjectColors[index] = color;
    });

    print("ASDADDD $index");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final theme = ref.watch(themeModeProvider);

        return Scaffold(
          backgroundColor: theme == ThemeMode.light
              ? Constants.lightThemeBackgroundColor
              : Constants.darkThemeBackgroundColor,
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            foregroundColor:
                theme == ThemeMode.light ? Colors.black : Colors.white,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Text(
              "New Subject",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  color:
                      theme == ThemeMode.light ? Colors.black : Colors.white),
            ),
          ),
          body: Container(
            color: theme == ThemeMode.light
                ? Constants.lightThemeClassExamDetailsBackgroundColor
                : Constants.darkThemeBackgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 26),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Subject Name',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 6,
                      ),
                      RegularTextField(
                        "Subject Name",
                        (value) {
                          FocusScope.of(context).unfocus();
                        },
                        TextInputType.name,
                        subjectNameController,
                        theme == ThemeMode.dark,
                        autofocus: false,
                      ),
                      Container(
                        height: 26,
                      ),
                      Text(
                        'Color',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 6,
                      ),
                      Container(
                        height: 56,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: subjectColors.length,
                            itemBuilder: (BuildContext content, int index) {
                              return SelectColorCard(
                                  subjectColors[index].itemColor,
                                  subjectColors[index].selected,
                                  index,
                                  _selectedCard);
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
