import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';

import '../../app.dart';
import './activities_classes_screen.dart';
import './activities_exams_screen.dart';
import './activities_tasks_screen.dart';
import 'activities_holidays_screen.dart';
import 'activities_extras_screen.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: theme == ThemeMode.light
              ? Constants.lightThemeBackgroundColor
              : Constants.darkThemeBackgroundColor,
          appBar: AppBar(
            backgroundColor: theme == ThemeMode.light
                ? Constants.lightThemeBackgroundColor
                : Constants.darkThemeBackgroundColor,
            shape: Border(
                bottom: BorderSide(color: Colors.black.withOpacity(0.1))),
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              "Activities",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  color:
                      theme == ThemeMode.light ? Colors.black : Colors.white),
            ),
            bottom: TabBar(
              indicatorWeight: 4,
              indicatorColor: theme == ThemeMode.light
                  ? Constants.blueButtonBackgroundColor
                  : Constants.darkThemePrimaryColor,
              labelColor: theme == ThemeMode.light
                  ? Constants.blueButtonBackgroundColor
                  : Constants.darkThemePrimaryColor,
              labelStyle: theme == ThemeMode.light
                  ? Constants.lightThemeTabBarTextStyle
                  : Constants.darkThemeTabBarTextStyle,
              unselectedLabelColor: theme == ThemeMode.light ? Colors.black.withOpacity(0.6) : Colors.white,
              unselectedLabelStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              isScrollable: true,
              tabs: const [
                Tab(
                  text: "Class",
                  // child: Text(
                  //   "Class",
                  //   style: theme == ThemeMode.light
                  //       ? Constants.lightThemeTabBarTextStyle
                  //       : Constants.darkThemeTabBarTextStyle,
                  // ),
                ),
                Tab(
                  text: "Exam",
                  // child: Text(
                  //   "Exam",
                  //   style: theme == ThemeMode.light
                  //       ? Constants.lightThemeTabBarTextStyle
                  //       : Constants.darkThemeTabBarTextStyle,
                  // ),
                ),
                Tab(
                  text: "Task",
                  //     child: Text(
                  //   "Task",
                  //   style: theme == ThemeMode.light
                  //       ? Constants.lightThemeTabBarTextStyle
                  //       : Constants.darkThemeTabBarTextStyle,
                  // ),
                ),
                Tab(
                  text: "Holiday",
                  // child: Text(
                  //   "Holiday",
                  //   style: theme == ThemeMode.light
                  //       ? Constants.lightThemeTabBarTextStyle
                  //       : Constants.darkThemeTabBarTextStyle,
                  // ),
                ),
                Tab(
                  text: "Xtra",
                  // child: Text(
                  //   "Xtra",
                  //   style: theme == ThemeMode.light
                  //       ? Constants.lightThemeTabBarTextStyle
                  //       : Constants.darkThemeTabBarTextStyle,
                  // ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
    
            children: [
              ActivitiesClassesScreen(),
              ActivitiesExamsScreen(),
              ActivitiesTasksScreen(),
              ActivitiesHolidaysScreen(),
              ActivitiesExtrasScreen(),
            ],
          ),
          // child: Container(
          //   //to control height of bottom sheet
          //   height: MediaQuery.of(context).size.height * 0.9,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(50.0),
          //   ),
          // ),
        ),
      );

      // return Scaffold(
      //   extendBodyBehindAppBar: false,
      //   appBar: AppBar(
      //     backgroundColor: Colors.transparent,
      //     shadowColor: Colors.transparent,
      //     foregroundColor: Colors.blue,
      //     elevation: 0.0,
      //     title: Text(
      //       "Activities",
      //       style: theme == ThemeMode.light
      //           ? Constants.lightThemeTitleTextStyle
      //           : Constants.darkThemeTitleTextStyle,
      //     ),
      //   ),
      // );
    });
  }
}
