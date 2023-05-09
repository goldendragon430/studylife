import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import 'package:group_list_view/group_list_view.dart';
import "package:collection/collection.dart";

import '../../app.dart';
import '../Home_Screens/exam_details_screen.dart';
import './custom_segmentedcontrol.dart';
import '../Models/holidays_datasource.dart';
import '../Widgets/HolidayWidgets/holiday_widget.dart';

import './holiday_xtra_detail_screen.dart';

class ActivitiesHolidaysScreen extends StatefulWidget {
  const ActivitiesHolidaysScreen({super.key});

  @override
  State<ActivitiesHolidaysScreen> createState() =>
      _ActivitiesHolidaysScreenState();
}

class _ActivitiesHolidaysScreenState extends State<ActivitiesHolidaysScreen> {
  final List<HolidayItem> _holidays = HolidayItem.holidays;
  int selectedTabIndex = 1;
  final todaysDate = DateTime.now();

  void _selectedCard(IndexPath index, HolidayItem item) {
     Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HolidayXtraDetailScreen(item: item),
            fullscreenDialog: true));
  }

  void _selectedTabWithIndex(int index) {
    setState(() {
      selectedTabIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
        final startOfWeek = todaysDate.findFirstDateOfTheWeek(todaysDate);
        final endOfWeek = todaysDate.findLastDateOfTheWeek(todaysDate);


      var groupByDate = groupBy(_holidays, (obj) => obj.dateFrom.isBetween(startOfWeek, endOfWeek));

      return Stack(
        children: [
          Container(
            height: 45,
            //width: double.infinity,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
            child: CustomSegmentedControl(
              _selectedTabWithIndex,
              tabs: {
                1: Text(
                  'Upcoming',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
                2: Text(
                  'Past',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: GroupListView(
              sectionsCount: groupByDate.keys.toList().length,
              countOfItemInSection: (int section) {
                return groupByDate.values.toList()[section].length;
              },
              itemBuilder: (BuildContext context, IndexPath index) {
                return HolidayWidget(
                    holidayItem: groupByDate.values.toList()[index.section]
                        [index.index],
                    cardIndex: index,
                    upNext: true,
                    cardselected: _selectedCard);
              },
              groupHeaderBuilder: (BuildContext context, int section) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: section == 0
                      ? Text(
                          'This week (${groupByDate.values.toList()[section].length})',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light
                                ? Colors.black.withOpacity(0.6)
                                : Colors.white.withOpacity(0.6),
                          ),
                        )
                      : Text(
                          'This month (${groupByDate.values.toList()[section].length})',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light
                                ? Colors.black.withOpacity(0.6)
                                : Colors.white.withOpacity(0.6),
                          ),
                        ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10),
              sectionSeparatorBuilder: (context, section) =>
                  SizedBox(height: 10),
            ),
          )
        ],
      );
    });
  }
}
