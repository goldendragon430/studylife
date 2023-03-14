import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Widgets/ProfileWidgets/collection_widget_four_items.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';

import '../../app.dart';
import '../Profile_Screens/profile_screen.dart';
import '../Widgets/ProfileWidgets/most_least_practiced_subject.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

void _selectedGridCard(int index) {
  print("Selected Grid card with Index: $index");
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return Scaffold(
        backgroundColor: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(
            "Profile",
            style: theme == ThemeMode.light
                ? Constants.lightThemeTitleTextStyle
                : Constants.darkThemeTitleTextStyle,
          ),
          actions: [
            // Navigate to the Search Screen
            TextButton(
              onPressed: () {
                // Navigator.pop(context);
              },
              child: Text(
                'Edit',
                style: theme == ThemeMode.light
                    ? Constants.lightThemeNavigationButtonStyle
                    : Constants.darkThemeNavigationButtonStyle,
              ),
            ),
          ],
        ),
        body: Container(
          alignment: Alignment.topCenter,
          height: double.infinity,
          child: ListView.builder(
              // controller: widget._controller,
              itemCount: 5,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return Container(
                      margin: const EdgeInsets.only(top: 21),
                      height: 146,
                      width: 146,
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                          color: theme == ThemeMode.light
                              ? Constants.lightThemeProfileImageCntainerColor
                              : Constants.darkThemeProfileImageCntainerColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 7,
                              color: theme == ThemeMode.light
                                  ? Constants
                                      .lightThemeProfileImageCntainerColor
                                  : Constants
                                      .darkThemeProfileImageCntainerColor),
                          image: DecorationImage(
                              // fit: BoxFit.fill,
                              image: AssetImage(
                                  'assets/images/ProfileImageTest.png'))),
                    );
                  case 1:
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 14),
                      child: Text(
                        'Mark Anderson',
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light
                                ? Constants.lightThemeTextSelectionColor
                                : Colors.white),
                      ),
                    );
                  case 2:
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 6),
                      child: Text('mark.anderson@gmail.com',
                          style: theme == ThemeMode.light
                              ? Constants.socialLoginLightButtonTextStyle
                              : Constants.socialLoginDarkButtonTextStyle),
                    );
                  case 3:
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 38),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: 4,
                        itemBuilder: (ctx, i) {
                          switch (i) {
                            case 0:
                              return CollectionWidgetFourItems(
                                title: "Pending Tasks",
                                cardIndex: i,
                                cardselected: _selectedGridCard,
                                subtitle: "Next 7 days",
                                numberFirst: 18,
                                isOverdue: false,
                                isPending: true,
                                numberSecond: 27,
                                isTasksOrStreak: false,
                              );
                            case 1:
                              return CollectionWidgetFourItems(
                                title: "Overdue Tasks",
                                cardIndex: i,
                                cardselected: _selectedGridCard,
                                subtitle: "Total",
                                numberFirst: 12,
                                isOverdue: true,
                                isPending: false,
                                isTasksOrStreak: false,
                              );
                            case 2:
                              return CollectionWidgetFourItems(
                                title: "Tasks Completed",
                                cardIndex: i,
                                cardselected: _selectedGridCard,
                                subtitle: "Last 7 days",
                                numberFirst: 9,
                                isOverdue: false,
                                isPending: false,
                                isTasksOrStreak: true,
                              );
                            case 3:
                              return CollectionWidgetFourItems(
                                title: "Your Streak",
                                cardIndex: i,
                                cardselected: _selectedGridCard,
                                subtitle: "Days with no tasks\ngoing late",
                                numberFirst: 9,
                                isOverdue: false,
                                isPending: false,
                                isTasksOrStreak: true,
                              );
                            default:
                          }
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 5,
                          mainAxisExtent: 149,
                        ),
                      ),
                    );
                  case 4:
                    return MostLeastPracticedSubject(
                        cardIndex: 0,
                        cardselected: () => {},
                        mostPracticedSubject: "MATHS",
                        mostPracticedSubjectColor: Colors.blue,
                        mostPracticedSubjectTasksCount: 39,
                        leastPracticedSubject: "BIOLOGY",
                        leastPracticedSubjectColor: Colors.green,
                        leastPracticedSubjectTasksCount: 7);
                  default:
                }
              }),
        ),
      );
    });
  }
}
