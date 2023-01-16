import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './tab_item.dart';
import 'main.dart';
import './Utilities/constants.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key,
      required this.currentTab,
      required this.onSelectTab,
      required this.theme});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final ThemeMode theme;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedLabelStyle: const TextStyle(
          height: 2.0,
          //color: Colors.black,
          fontFamily: "Roboto",
          fontSize: 11,
          fontWeight: FontWeight.w400),
      selectedLabelStyle: const TextStyle(
          height: 2.0,
          //  color: Colors.black,
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
      selectedItemColor: theme == ThemeMode.dark
          ? Constants.darkThemeTextSelectionColor
          : Constants.lightThemeTextSelectionColor,
      unselectedItemColor: theme == ThemeMode.dark
          ? Constants.darkThemeUnselectedTextColor
          : Constants.lightThemeUnselectedTextColor,
      backgroundColor: theme == ThemeMode.dark
          ? Constants.darkThemeNavigationBarColor
          : Colors.white,
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: theme == ThemeMode.dark ? tabItem.iconDark : tabItem.icon,
      activeIcon:
          theme == ThemeMode.dark ? tabItem.activeDarkIcon : tabItem.activeIcon,
      label: tabItem.name,
    );
  }
}
