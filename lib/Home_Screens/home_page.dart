import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_study_life_flutter/Models/API/subject.dart';
import 'package:my_study_life_flutter/Widgets/ClassWidgets/class_widget.dart';
import 'dart:convert';
import 'dart:math' as math;

import '../app.dart';
import '../Utilities/constants.dart';
import './search_page.dart';
import '../Extensions/extensions.dart';
import '../Widgets/home_tab_bar_card.dart';
import '../Models/home_tab_items.dart';
import '../Models/class_datasource.dart';
import '../Models/exam_datasource.dart';
import '../Widgets/exam_widget.dart';
import '../Widgets/quotes_widget.dart';
import './class_details_screen.dart';
import '../login_state.dart';
import './exam_details_screen.dart';

import '../Models/API/result.dart';
import '../Widgets/custom_snack_bar.dart';
import '../Services/navigation_service.dart';
import '../Networking/sync_controller.dart';
import '../Models/Services/storage_service.dart';
import '../Models/Services/storage_item.dart';
import '../Models/API/classmodel.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.detailsPath});
  // final ValueChanged<int>? onPush;
  late ScrollController _controller;
  final String detailsPath;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  final List<HomeTabItem> _homeTabItemsDataSource = HomeTabItem.tabItems;
  // final List<ClassStatic> _classes = ClassStatic.classes;
  final List<ExamStatic> _exams = ExamStatic.exams;
  final StorageService _storageService = StorageService();

  List<ClassModel> _classes = [];

  int selectedTabIndex = 0;
  final SyncController _syncController = SyncController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      syncData();
    });
  }

  void syncData() async {
    Result response = await _syncController.syncAll();
    if (response is ErrorState) {
      ErrorState error = response as ErrorState;

      CustomSnackBar.show(context, CustomSnackBarType.error, error.msg, true);
    }

    if (response is SuccessState) {
      var subjectsData = await _storageService.readSecureData("user_subjects");

      List<dynamic> decodedData = jsonDecode(subjectsData ?? "");

      List<Subject> dataDecodedList = List<Subject>.from(
        decodedData.map((x) => Subject.fromJson(x as Map<String, dynamic>)),
      );
      // print("ASDADADS ${dataDecodedList}");

      // // var _classes = SyncController.classes;

      // for (var subject in dataDecodedList) {
      //   print("SUBJECtS ${subject.subjectName}");
      // }
      var classesData = await _storageService.readSecureData("user_classes");

      List<dynamic> decodedDataClasses = jsonDecode(classesData ?? "");

      setState(() {
        _classes = List<ClassModel>.from(
          decodedDataClasses
              .map((x) => ClassModel.fromJson(x as Map<String, dynamic>)),
        );
      });
    }
  }

  String _getGreetingMessage() {
    String greeting = "";
    int hours = now.hour;

    if (hours >= 1 && hours <= 12) {
      greeting = "Good Morning";
    } else if (hours >= 12 && hours <= 16) {
      greeting = "Good Afternoon";
    } else if (hours >= 16 && hours <= 21) {
      greeting = "Good Evening";
    } else if (hours >= 21 && hours <= 24) {
      greeting = "Good Night";
    }

    return greeting;
  }

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      for (var item in _homeTabItemsDataSource) {
        item.selected = false;
      }

      _homeTabItemsDataSource[index].selected = true;
      print("CARD SELECTED $index");
    });
  }

  void _logOut(BuildContext context, WidgetRef ref) {
    ref.read(loginStateProvider).loggedIn = false;
    // context.beamToNamed('/login');
    //context.go(Constants.homeRouteName);
  }

  void _selectedCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ClassDetailsScreen(),
            fullscreenDialog: true));
  }

  void _selectedExamCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ExamDetailsScreen(),
            fullscreenDialog: true));
  }

  // Sliver
  SliverPersistentHeader makeHeader(ThemeMode theme) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 51.0,
        maxHeight: 51.0,
        child: Container(
          //color: Colors.white,
          color: theme == ThemeMode.light
              ? Constants.lightThemeBackgroundColor
              : Constants.darkThemeBackgroundColor,
          child: Stack(
            children: [
              Container(
                // Tab items
                height: 51,
                width: double.infinity,
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _homeTabItemsDataSource
                      .mapIndexed((e, i) => TabBarCard(
                            title: e.title,
                            badgeNumber: e.badgeNumber,
                            selected: e.selected,
                            cardIndex: e.cardIndex,
                            cardselected: _selectTab,
                            isLightTheme: theme == ThemeMode.light,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return ScaffoldMessenger(
        child: Scaffold(
            backgroundColor: theme == ThemeMode.light
                ? Constants.lightThemeBackgroundColor
                : Constants.darkThemeBackgroundColor,
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.blue,
              elevation: 0.0,
              title: const Text(""),
              actions: [
                // Navigate to the Search Screen
                IconButton(
                  onPressed: () => _logOut(context, ref),
                  icon: theme == ThemeMode.light
                      ? Image.asset('assets/images/SearchIconLightTheme.png')
                      : Image.asset('assets/images/SearchIconDarkTheme.png'),
                ),
              ],
            ),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CustomScrollView(
                //controller: widget.controller,
                slivers: <Widget>[
                  SliverFixedExtentList(
                    itemExtent: 123.0,
                    delegate: SliverChildListDelegate(
                      [
                        Container(
                          height: 103,
                          child: Stack(
                            children: [
                              Container(
                                // Greeting message
                                height: 19,
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.only(top: 5),
                                child: Text(
                                  _getGreetingMessage(),
                                  style: theme == ThemeMode.light
                                      ? Constants.lightThemeGreetingMessageStyle
                                      : Constants.darkThemeGreetingMessageStyle,
                                ),
                              ),
                              Container(
                                // User Name
                                height: 42,
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.only(top: 27),
                                child: Text(
                                  'UserName',
                                  style: theme == ThemeMode.light
                                      ? Constants.lightThemeTitleTextStyle
                                      : Constants.darkThemeTitleTextStyle,
                                ),
                              ),
                              Container(
                                // Today's date
                                height: 42,
                                alignment: Alignment.topCenter,
                                margin: const EdgeInsets.only(top: 72),
                                child: Text(
                                  now.getFormattedDate(now),
                                  style: theme == ThemeMode.light
                                      ? Constants.lightThemeTodayDateTextStyle
                                      : Constants.darkThemeTodayDateTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  makeHeader(theme),
                  if (selectedTabIndex == 0) ...[
                    SliverFixedExtentList(
                        itemExtent: 130,
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return ClassWidget(
                              classItem: _classes[index],
                              cardIndex: index,
                              upNext: true,
                              cardselected: _selectedCard);
                        }, childCount: _classes.length)),
                  ],
                  if (selectedTabIndex == 1) ...[
                    SliverFixedExtentList(
                        itemExtent: 145,
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return ExamWidget(
                              classItem: _exams[index],
                              cardIndex: index,
                              upNext: true,
                              cardselected: _selectedExamCard);
                        }, childCount: _exams.length)),
                  ],
                  if (selectedTabIndex == 2) ...[
                    SliverFixedExtentList(
                        itemExtent: 145,
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return QuotesWidget(
                              quote: "Wake up determined, Go to bed Satisfied",
                              cardIndex: index,
                              cardselected: _selectedCard);
                        }, childCount: 1)),
                  ],
                ],
              ),
              // child: Stack(
              //   children: [
              //     // Container(
              //     //   // Greeting message
              //     //   height: 19,
              //     //   alignment: Alignment.topCenter,
              //     //   margin: const EdgeInsets.only(top: 5),
              //     //   child: Text(
              //     //     _getGreetingMessage(),
              //     //     style: theme == ThemeMode.light
              //     //         ? Constants.lightThemeGreetingMessageStyle
              //     //         : Constants.darkThemeGreetingMessageStyle,
              //     //   ),
              //     // ),
              //     // Container(
              //     //   // User Name
              //     //   height: 42,
              //     //   alignment: Alignment.topCenter,
              //     //   margin: const EdgeInsets.only(top: 27),
              //     //   child: Text(
              //     //     'UserName',
              //     //     style: theme == ThemeMode.light
              //     //         ? Constants.lightThemeTitleTextStyle
              //     //         : Constants.darkThemeTitleTextStyle,
              //     //   ),
              //     // ),
              //     // Container(
              //     //   // Today's date
              //     //   height: 42,
              //     //   alignment: Alignment.topCenter,
              //     //   margin: const EdgeInsets.only(top: 72),
              //     //   child: Text(
              //     //     now.getFormattedDate(now),
              //     //     style: theme == ThemeMode.light
              //     //         ? Constants.lightThemeTodayDateTextStyle
              //     //         : Constants.darkThemeTodayDateTextStyle,
              //     //   ),
              //     // ),
              //     // Container(
              //     //   // Tab items
              //     //   height: 51,
              //     //   width: double.infinity,
              //     //   alignment: Alignment.topCenter,
              //     //   margin:
              //     //       const EdgeInsets.only(top: 130, left: 20, right: 20),
              //     //   child: Row(
              //     //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     //     children: _homeTabItemsDataSource
              //     //         .mapIndexed((e, i) => TabBarCard(
              //     //               title: e.title,
              //     //               badgeNumber: e.badgeNumber,
              //     //               selected: e.selected,
              //     //               cardIndex: e.cardIndex,
              //     //               cardselected: _selectTab,
              //     //               isLightTheme: theme == ThemeMode.light,
              //     //             ))
              //     //         .toList(),
              //     //   ),
              //     // ),
              //     if (selectedTabIndex == 0) ...[
              //       // Classes
              //       Container(
              //         alignment: Alignment.topCenter,
              //         height: double.infinity,
              //         margin: const EdgeInsets.only(top: 186),
              //         child: ListView.builder(
              //             // controller: widget._controller,
              //             itemCount: _classes.length,
              //             itemBuilder: (context, index) {
              //               return ClassWidget(
              //                   classItem: _classes[index],
              //                   cardIndex: index,
              //                   upNext: true,
              //                   cardselected: _selectedCard);
              //             }),
              //       ),
              //     ],
              //     if (selectedTabIndex == 1) ...[
              //       // Exams
              //       Container(
              //         alignment: Alignment.topCenter,
              //         height: double.infinity,
              //         margin: const EdgeInsets.only(top: 186),
              //         child: ListView.builder(
              //             // controller: widget._controller,
              //             itemCount: _exams.length,
              //             itemBuilder: (context, index) {
              //               return ExamWidget(
              //                   classItem: _exams[index],
              //                   cardIndex: index,
              //                   upNext: true,
              //                   cardselected: _selectedExamCard);
              //             }),
              //       ),
              //     ],
              //     if (selectedTabIndex == 2) ...[
              //       // Tasks Due
              //       Container(
              //         alignment: Alignment.topCenter,
              //         height: double.infinity,
              //         margin: const EdgeInsets.only(top: 186),
              //         child: ListView.builder(
              //             // controller: widget._controller,
              //             itemCount: 1,
              //             itemBuilder: (context, index) {
              //               return QuotesWidget(
              //                   quote:
              //                       "Wake up determined, Go to bed Satisfied",
              //                   cardIndex: index,
              //                   cardselected: _selectedCard);
              //             }),
              //       ),
              //     ],
              //   ],
              // ),
            )),
      );
    });
  }
}
