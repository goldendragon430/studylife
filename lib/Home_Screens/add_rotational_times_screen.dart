import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '../../Models/subjects_datasource.dart';
import 'package:intl/intl.dart';

import '../app.dart';
import '../Widgets/tag_card.dart';
import '../Widgets/regular_teztField.dart';
import '../Models/API/rotation_time.dart';
import '../../Widgets/custom_snack_bar.dart';
import '../Widgets/ClassWidgets/select_times.dart';

class AddRotationalTimesScreen extends StatefulWidget {
  final bool isEditing;
  final Function timeAdded;
  final bool isWeekly;
  const AddRotationalTimesScreen({
    super.key,
    required this.isEditing,
    required this.timeAdded,
    required this.isWeekly,
  });

  @override
  State<AddRotationalTimesScreen> createState() =>
      _AddRotationalTimesScreenState();
}

class _AddRotationalTimesScreenState extends State<AddRotationalTimesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<ClassTagItem> _types = ClassTagItem.dayTypes;
  final List<ClassTagItem> _startDays = ClassTagItem.startDays;
  final List<ClassTagItem> _startDaysLetter = ClassTagItem.startWeek;
  final List<ClassTagItem> _rotationWeeks = ClassTagItem.rotationWeeks;

  RotationTimeSetting _rotationSetting = RotationTimeSetting();
  List<String> letteredDays = [];
  List<String> normalDays = [];

  final textController = TextEditingController();

  int selectedTabIndex = 0;
  int rotationWeekIndex = 0;

  int selectedTabIndexDayOfWeek = 0;
  int selectedTabIndexRotationDay = 0;

  void _selectTab(int index) {
    // DAY TYPE
    print("4 $index");

    setState(() {
      selectedTabIndex = index;
      for (var item in _types) {
        item.selected = false;
      }

      _types[index].selected = true;
      _rotationSetting.dayType = _types[index].title;
    });
  }

  void _selectWeekTabTab(int index) {
    print("3 $index");

    setState(() {
      rotationWeekIndex = index;
      for (var item in _rotationWeeks) {
        item.selected = false;
      }

      _rotationWeeks[index].selected = true;
      _rotationSetting.rotationWeek = rotationWeekIndex;
    });
  }

  void _selectRotationDaysDayOfWeek(int index) {
    //ABCD
    print("2 $index");

    setState(() {
      // selectedTabIndexDayOfWeek = index;
      // for (var item in _startDaysLetter) {
      //   item.selected = false;
      // }

      _startDaysLetter[index].selected = !_startDaysLetter[index].selected;

      var existingItem = letteredDays.firstWhere(
          (itemToCheck) => itemToCheck == _startDaysLetter[index].title,
          orElse: () => "");

      if (_startDaysLetter[index].selected) {
        if (existingItem.isEmpty) {
          letteredDays.add(_startDaysLetter[index].title);
        }
      } else {
        if (existingItem.isNotEmpty) {
          letteredDays.remove(_startDaysLetter[index].title);
        }
      }

      print("LETTERED ${letteredDays.toString()}");
    });
  }

  void _selectRotationDaysRotationDay(int index) {
    //Mon, Tue...
    print("1 $index");
    setState(() {
      // selectedTabIndexRotationDay = index;
      // for (var item in _startDays) {
      //   item.selected = false;
      // }

      _startDays[index].selected = !_startDays[index].selected;

      var existingItem = normalDays.firstWhere(
          (itemToCheck) => itemToCheck == _startDays[index].title,
          orElse: () => "");

      if (_startDays[index].selected) {
        if (existingItem.isEmpty) {
          normalDays.add(_startDays[index].title);
        }
      } else {
        if (existingItem.isNotEmpty) {
          normalDays.remove(_startDays[index].title);
        }
      }
    });
  }

  void _selectedTimes(DateTime time, bool isTimeFrom) {
    String formattedDate = DateFormat('HH:mm').format(time);

    if (isTimeFrom) {
      _rotationSetting.startTime = formattedDate;
    } else {
      _rotationSetting.endtime = formattedDate;
    }
  }

  void _saveTapped() {
    if (widget.isWeekly) {
      //Check if all fields are filled
      if (normalDays.isEmpty) {
        return;
      } else {
        _rotationSetting.rotationDaysNormal = normalDays;
      }

      if (_rotationSetting.startTime == null ||
          _rotationSetting.endtime == null) {
        return;
      }

      widget.timeAdded(_rotationSetting);
      Navigator.pop(context);
    } else {
      //Check if all fields are filled
      if (_rotationSetting.dayType == "Day of Week") {
        if (normalDays.isEmpty) {
          return;
        } else {
          _rotationSetting.rotationDaysNormal = normalDays;
        }
      } else {
        if (letteredDays.isEmpty) {
          return;
        } else {
          _rotationSetting.rotationDaysLettered = letteredDays;
        }
      }

      if (_rotationSetting.startTime == null ||
          _rotationSetting.endtime == null) {
        return;
      }

      widget.timeAdded(_rotationSetting);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    // if (widget.isEditing) {
    //   textController.text = widget.score ?? "";

    //   switch (widget.scoreType) {
    //     case 'percentage':
    //       selectedTabIndex = 0;
    //       _types[selectedTabIndex].selected = true;
    //       break;
    //     case "number":
    //       selectedTabIndex = 1;
    //       _types[selectedTabIndex].selected = true;
    //       break;
    //     case "letter":
    //       selectedTabIndex = 2;
    //       _types[selectedTabIndex].selected = true;
    //       break;
    //     default:
    //   }
    // }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1600,
      ),
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BottomSheet(
          animationController: _controller,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height - 340,
              color: theme == ThemeMode.light
                  ? Constants.lightThemeBackgroundColor
                  : Constants.darkThemeBackgroundColor,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 28),
                    alignment: Alignment.topCenter,
                    child: Text(
                      widget.isEditing ? 'Edit Time' : 'New Time',
                      style: theme == ThemeMode.light
                          ? Constants.lightThemeTitleTextStyle
                          : Constants.darkThemeTitleTextStyle,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 18, left: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeNavigationButtonStyle
                            : Constants.darkThemeNavigationButtonStyle,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 18, right: 20),
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () => _saveTapped(),
                      child: Text(
                        'Save',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeNavigationButtonStyle
                            : Constants.darkThemeNavigationButtonStyle,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 36, top: 85, right: 36),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.isWeekly) ...[
                          Text(
                            'Rotation Week*',
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeSubtitleTextStyle
                                : Constants.darkThemeSubtitleTextStyle,
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            height: 20,
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            children: _rotationWeeks
                                .mapIndexed((e, i) => TagCard(
                                      title: e.title,
                                      selected: e.selected,
                                      cardIndex: e.cardIndex,
                                      cardselected: _selectWeekTabTab,
                                      isAddNewCard: e.isAddNewCard,
                                    ))
                                .toList(),
                          ),
                          Container(
                            height: 22,
                          ),
                          Text(
                            'Rotation Days*',
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeSubtitleTextStyle
                                : Constants.darkThemeSubtitleTextStyle,
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            height: 20,
                          ),
                        ],
                        if (!widget.isWeekly) ...[
                          Text(
                            'Day Type*',
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeSubtitleTextStyle
                                : Constants.darkThemeSubtitleTextStyle,
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            height: 20,
                          ),
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            children: _types
                                .mapIndexed((e, i) => TagCard(
                                      title: e.title,
                                      selected: e.selected,
                                      cardIndex: e.cardIndex,
                                      cardselected: _selectTab,
                                      isAddNewCard: e.isAddNewCard,
                                    ))
                                .toList(),
                          ),
                          Container(
                            height: 22,
                          ),
                          Text(
                            'Rotation Days*',
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeSubtitleTextStyle
                                : Constants.darkThemeSubtitleTextStyle,
                            textAlign: TextAlign.left,
                          ),
                          Container(
                            height: 20,
                          ),
                        ],
                        if (selectedTabIndex == 0) ...[
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            children: _startDays
                                .mapIndexed((e, i) => TagCard(
                                      title: e.title,
                                      selected: e.selected,
                                      cardIndex: e.cardIndex,
                                      cardselected:
                                          _selectRotationDaysRotationDay,
                                      isAddNewCard: e.isAddNewCard,
                                    ))
                                .toList(),
                          ),
                        ],
                        if (selectedTabIndex == 1) ...[
                          Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.start,
                            children: _startDaysLetter
                                .mapIndexed((e, i) => TagCard(
                                      title: e.title,
                                      selected: e.selected,
                                      cardIndex: e.cardIndex,
                                      cardselected:
                                          _selectRotationDaysDayOfWeek,
                                      isAddNewCard: e.isAddNewCard,
                                    ))
                                .toList(),
                          ),
                        ],
                        Container(
                          height: 22,
                        ),
                        SelectTimes(
                          // classItem: newClass,
                          timeSelected: _selectedTimes,
                          isModalPopup: true,
                        ),
                        Container(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 0, top: 421, right: 0),
                    height: 64,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          onClosing: () {
            // Navigator.pop(context);
          },
        ),
      );
    });
  }
}
