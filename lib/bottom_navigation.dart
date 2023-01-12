import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './tab_item.dart';
import 'main.dart';


class BottomNavigation extends StatelessWidget {
   BottomNavigation(
      {super.key, required this.currentTab, required this.onSelectTab, required this.theme});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
 final ThemeMode theme;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        unselectedLabelStyle: const TextStyle(
                            height: 2.0,
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
        selectedLabelStyle: const TextStyle(
                            height: 2.0,
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(TabItem.tabItems[0]),
          _buildItem(TabItem.tabItems[1]),
          _buildItem(TabItem.tabItems[2]),
          _buildItem(TabItem.tabItems[3]),
          _buildItem(TabItem.tabItems[4])
        ],
        onTap: (index) => onSelectTab(
          TabItem.tabItems[index],
        ),
        currentIndex: currentTab.index,
        selectedItemColor: Colors.black,
      );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {

    return BottomNavigationBarItem(
      icon: theme == ThemeMode.dark
                        ? tabItem.iconDark : tabItem.icon,
      activeIcon: theme == ThemeMode.dark
                        ? tabItem.activeDarkIcon : tabItem.activeIcon,
      label: tabItem.name,
    );
  }

  Color _colorTabMatching(TabItem item) {
    return Colors.grey;
  }
}
