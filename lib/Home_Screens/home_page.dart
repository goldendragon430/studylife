import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_study_life_flutter/Widgets/ClassWidgets/class_widget.dart';

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

class HomePage extends StatefulWidget {
  HomePage({super.key, this.onPush});
  final ValueChanged<int>? onPush;
  late ScrollController _controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DateTime now = DateTime.now();
  final List<HomeTabItem> _homeTabItemsDataSource = HomeTabItem.tabItems;
  final List<ClassStatic> _classes = ClassStatic.classes;
  final List<ExamStatic> _exams = ExamStatic.exams;

  int selectedTabIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () {});
  // }

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

  void _selectedCard(int index) {
    print("CLass ITEM SELECTED $index");
         Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ClassDetailsScreen(),
            fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return Scaffold(
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
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SearchPage())),
                icon: theme == ThemeMode.light
                    ? Image.asset('assets/images/SearchIconLightTheme.png')
                    : Image.asset('assets/images/SearchIconDarkTheme.png'),
              ),
            ],
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
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
                Container(
                  // Tab items
                  height: 51,
                  width: double.infinity,
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.only(top: 130, left: 20, right: 20),
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
                if (selectedTabIndex == 0) ...[
                  // Classes
                    Container(
                  alignment: Alignment.topCenter,
                  height: double.infinity,
                  margin: const EdgeInsets.only(top: 186),
                  child: ListView.builder(
                     // controller: widget._controller,
                      itemCount: _classes.length,
                      itemBuilder: (context, index) {
                        return ClassWidget(
                            classItem: _classes[index],
                            cardIndex: index,
                            upNext: true,
                            cardselected: _selectedCard);
                      }),
                ),
                ],
                 if (selectedTabIndex == 1) ...[
                  // Exams
                    Container(
                  alignment: Alignment.topCenter,
                  height: double.infinity,
                  margin: const EdgeInsets.only(top: 186),
                  child: ListView.builder(
                     // controller: widget._controller,
                      itemCount: _exams.length,
                      itemBuilder: (context, index) {
                        return ExamWidget(
                            classItem: _exams[index],
                            cardIndex: index,
                            upNext: true,
                            cardselected: _selectedCard);
                      }),
                ),
                ],
                  if (selectedTabIndex == 2) ...[
                  // Tasks Due
                    Container(
                  alignment: Alignment.topCenter,
                  height: double.infinity,
                  margin: const EdgeInsets.only(top: 186),
                  child: ListView.builder(
                     // controller: widget._controller,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return QuotesWidget(
                            quote: "Wake up determined, Go to bed Satisfied",
                            cardIndex: index,
                            cardselected: _selectedCard);
                      }),
                ),
                ],
              
              ],
            ),
          ));
    });
  }
}
