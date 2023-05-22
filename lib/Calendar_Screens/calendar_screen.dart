import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:calendar_view/calendar_view.dart';

import '../../app.dart';
import '../Activities_Screens/custom_segmentedcontrol.dart';
import '../Models/event.dart';
import '../Widgets/CalendarWidgets/day_view_widget.dart';
import '../Widgets/CalendarWidgets/month_view_widget.dart';
import '../Widgets/CalendarWidgets/week_view_widget.dart';
import '.././Models/class_datasource.dart';
import '../Home_Screens/class_details_screen.dart';
import '../Widgets/ClassWidgets/class_widget.dart';
import '../Widgets/custom_centered_dialog.dart';
import '../Models/API/classmodel.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int selectedTabIndex = 1;
  String currentMonthName = "";
  String currentWeekName = "";
  DateTime currentSelectedDate = DateTime.now();
  String currentSelectedDayStringName = "";
  final ValueNotifier<DateTime> currentSelectedDay =
      ValueNotifier(DateTime.now());

  final List<ClassStatic> _classes = ClassStatic.classes;

  static GlobalKey<MonthViewState> stateKey = GlobalKey<MonthViewState>();
  final GlobalKey<DayViewState> dayStateKey = GlobalKey<DayViewState>();
  final GlobalKey<WeekViewState> weekStateKey = GlobalKey<WeekViewState>();

  @override
  void initState() {
    super.initState();
    currentMonthName = _getCurrentMonthName();
    currentWeekName = _getCurrentWeekName();
    currentSelectedDayStringName = _getCurrentDayName();
  }

  void _selectedCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ClassDetailsScreen(ClassModel()),
            fullscreenDialog: true));
  }

  void _selectedTabWithIndex(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  String _getCurrentMonthName() {
    final today = DateTime.now();

    final DateFormat monthFormat = DateFormat('MMMM');

    return monthFormat.format(today);
  }

  String _getCurrentWeekName() {
    final today = currentSelectedDate;
    final DateTime firstDayOfWeek = today.firstDayOfWeek();
    final endofWeekDate = firstDayOfWeek.add(Duration(days: 6));
    final DateFormat weekFormat = DateFormat('dd MMM, yyyy');

    return "${firstDayOfWeek.day} - ${weekFormat.format(endofWeekDate)}";
  }

  String _getCurrentDayName() {
    final today = DateTime.now();

    final DateFormat dayFormat = DateFormat('EEEEE, MMMM d yyyy');

    return dayFormat.format(today);
  }

  void _tappedLeftNavigationButton() {
    if (selectedTabIndex == 1) {
      dayStateKey.currentState?.animateToDate(currentSelectedDate);
    }
    if (selectedTabIndex == 2) {
      weekStateKey.currentState?.previousPage();
    }
    if (selectedTabIndex == 3) {
      stateKey.currentState?.previousPage();
    }

    currentSelectedDate =
        DateTime(currentSelectedDate.year, currentSelectedDate.month - 1, 1);

    setState(() {
      final DateFormat monthFormat = DateFormat('MMMM');
      currentSelectedDay.value = currentSelectedDate;
      currentWeekName = _getCurrentWeekName();
      currentMonthName = monthFormat.format(currentSelectedDay.value);
    });
  }

  void _tappedRightNavigationButton() {
    if (selectedTabIndex == 1) {
      dayStateKey.currentState?.animateToDate(currentSelectedDate);
    }
    if (selectedTabIndex == 2) {
      weekStateKey.currentState?.nextPage();
    }
    if (selectedTabIndex == 3) {
      stateKey.currentState?.nextPage();
    }

    currentSelectedDate =
        DateTime(currentSelectedDate.year, currentSelectedDate.month + 1, 1);

    setState(() {
      final DateFormat monthFormat = DateFormat('MMMM');
      currentSelectedDay.value = currentSelectedDate;
      currentWeekName = _getCurrentWeekName();
      currentMonthName = monthFormat.format(currentSelectedDay.value);
    });
    //dayStateKey.currentState?.
  }

  void _calendarPageChanged(DateTime date, int page) {
    final DateFormat monthFormat = DateFormat('MMMM');

    setState(() {
      currentSelectedDay.value = date;
      currentMonthName = monthFormat.format(date);
    });
  }

  void _calendarDaySelected(
      List<CalendarEventData<Event>> events, DateTime date) {
    final DateFormat dayFormat = DateFormat('EEEEE, MMMM d yyyy');

    setState(() {
      currentSelectedDay.value = date;
      currentSelectedDayStringName = dayFormat.format(date);
    });
  }

  void _weekDayCalendarPageChanged(DateTime date) {
    final DateFormat monthFormat = DateFormat('MMMM');

    setState(() {
      currentSelectedDate = date;
      currentSelectedDay.value = date;
      currentMonthName = monthFormat.format(date);
      dayStateKey.currentState?.animateToDate(currentSelectedDate);
    });
  }

  void _weekDayCalendarDaySelected(DateTime date) {
    final DateFormat dayFormat = DateFormat('EEEEE, MMMM d yyyy');

    setState(() {
      currentSelectedDate = date;
      currentSelectedDay.value = date;
      dayStateKey.currentState?.animateToDate(date);
      //currentSelectedDayStringName = dayFormat.format(date);
    });
  }

  void _weekViewPageChanged(DateTime date, int page) {
    final endofWeekDate = date.add(Duration(days: 6));
    final DateFormat weekFormat = DateFormat('dd MMM, yyyy');

    setState(() {
      currentSelectedDate = date;
      currentSelectedDay.value = date;
      currentWeekName = "${date.day} - ${weekFormat.format(endofWeekDate)}";
      // dayStateKey.currentState?.animateToDate(currentSelectedDate);
    });
  }

  void _weekViewEventTapped(
      List<CalendarEventData<Event>> events, DateTime date) {}

  void _openLegend() {
    showCenteredPopup(context);
  }

  showCenteredPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return Scaffold(
        backgroundColor: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        floatingActionButton: Container(
          padding: const EdgeInsets.only(top: 45),
          height: 125,
          width: 65,
          child: FloatingActionButton(
            heroTag: null,
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            highlightElevation: 0,
            onPressed: _openLegend,
            elevation: 0.0,
            child: Image.asset('assets/images/OpenLegendButtonIcon.png'),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(
            "Schedule",
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: theme == ThemeMode.light ? Colors.black : Colors.white),
          ),
          actions: [
            // Navigate to the Search Screen
            TextButton(
              onPressed: () {
                // Navigator.pop(context);
              },
              child: Text(
                'Today',
                style: theme == ThemeMode.light
                    ? Constants.lightThemeNavigationButtonStyle
                    : Constants.darkThemeNavigationButtonStyle,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              height: 45,
              //width: double.infinity,
              margin: const EdgeInsets.only(left: 40, right: 40, top: 16),
              child: CustomSegmentedControl(
                _selectedTabWithIndex,
                tabs: {
                  1: Text(
                    'Days',
                    style: theme == ThemeMode.light
                        ? Constants.lightThemeRegular14TextSelectedStyle
                        : Constants.darkThemeRegular14TextStyle,
                  ),
                  2: Text(
                    'Week',
                    style: theme == ThemeMode.light
                        ? Constants.lightThemeRegular14TextSelectedStyle
                        : Constants.darkThemeRegular14TextStyle,
                  ),
                  3: Text(
                    'Month',
                    style: theme == ThemeMode.light
                        ? Constants.lightThemeRegular14TextSelectedStyle
                        : Constants.darkThemeRegular14TextStyle,
                  ),
                },
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 80, left: 40, right: 40),
              decoration: BoxDecoration(
                color: theme == ThemeMode.light
                    ? Constants.lightThemeSecondaryColor
                    : Constants.darkThemeDividerColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: _tappedLeftNavigationButton,
                    icon: theme == ThemeMode.light
                        ? Image.asset('assets/images/ArrowLeftLightTheme.png')
                        : Image.asset('assets/images/ArrowLeftDarkTheme.png'),
                  ),
                  Container(
                    width: 40,
                  ),
                  Text(
                    selectedTabIndex != 2 ? currentMonthName : currentWeekName,
                    style: theme == ThemeMode.light
                        ? Constants.lightThemeRegular14TextSelectedStyle
                        : Constants.darkThemeRegular14TextStyle,
                  ),
                  Container(
                    width: 40,
                  ),
                  IconButton(
                    onPressed: _tappedRightNavigationButton,
                    icon: theme == ThemeMode.light
                        ? Image.asset('assets/images/ArrowRightLightTheme.png')
                        : Image.asset('assets/images/ArrowRightDarkTheme.png'),
                  ),
                ],
              ),
            ),
            Container(
              height: 20,
            ),
            if (selectedTabIndex == 1) ...[
              Container(
                  margin: EdgeInsets.only(top: 75),
                  child: DayViewWidget(
                    state: dayStateKey,
                    daySelected: _weekDayCalendarDaySelected,
                    pageChanged: _weekDayCalendarPageChanged,
                    selectedDay: currentSelectedDay.value,
                  )),
            ],
            if (selectedTabIndex == 2) ...[
              Container(
                  margin: EdgeInsets.only(top: 135),
                  child: WeekViewWidget(
                    state: weekStateKey,
                    onPageChange: _weekViewPageChanged,
                    onEventTap: _weekViewEventTapped,
                  )),
            ],
            if (selectedTabIndex == 3) ...[
              Stack(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(top: 135, left: 20, right: 20),
                    height: 281,
                    padding: EdgeInsets.only(bottom: 10, left: 10, right: 4),
                    decoration: BoxDecoration(
                      color: theme == ThemeMode.light
                          ? Colors.white
                          : Constants.darkThemeSecondaryBackgroundColor,
                      border: Border.all(
                        width: 0,
                        color: theme == ThemeMode.dark
                            ? Colors.white
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: theme == ThemeMode.light
                              ? Colors.black.withOpacity(.1)
                              : Colors.white.withOpacity(.1),
                          blurRadius: 15.0, // soften the shadow
                          spreadRadius: 5.0,
                          offset: Offset(
                            0.0,
                            2.0,
                          ),
                        ),
                      ],
                    ),
                    child: MonthViewWidget(
                      state: stateKey,
                      pageChanged: _calendarPageChanged,
                      daySelected: _calendarDaySelected,
                      currentSelectedDay: currentSelectedDay.value,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 430, left: 20),
                    child: Text(currentSelectedDayStringName,
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeTaskDueDescriptionTextStyle),
                  ),
                  // Container(
                  //   alignment: Alignment.topCenter,
                  //   height: double.infinity,
                  //   margin: const EdgeInsets.only(top: 450),
                  //   child: ListView.builder(
                  //       // controller: widget._controller,
                  //       itemCount: _classes.length,
                  //       itemBuilder: (context, index) {
                  //         return ClassWidget(
                  //             classItem: _classes[index],
                  //             cardIndex: index,
                  //             upNext: true,
                  //             cardselected: _selectedCard);
                  //       }),
                  // ),
                ],
              ),
            ],
          ],
        ),
      );
    });
  }
}
