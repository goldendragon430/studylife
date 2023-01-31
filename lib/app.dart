import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './bottom_navigation.dart';
import './tab_item.dart';
import './tab_navigator.dart';
import 'main.dart';
import 'Home_Screens/create_screen.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  var brightness = WidgetsBinding.instance.window.platformBrightness;

  if (brightness == Brightness.dark) {
    return ThemeMode.dark;
  } else {
    return ThemeMode.light;
  }
});

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => AppState();
}

class AppState extends ConsumerState<App> with WidgetsBindingObserver, SingleTickerProviderStateMixin {
 // late AnimationController controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
 
  //    _controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(
  //       milliseconds: 1600,
  //     ),
  //   );

  //     _controller.addListener(() {
  //   setState(() {});
  // });

  //   _controller.forward();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
      //  controller.dispose();
    super.dispose();
   // _controller.dispose();

  }

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;
    //inform listeners and rebuild widget tree

    if (brightness == Brightness.dark) {
      ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
    } else {
      ref.read(themeModeProvider.notifier).state = ThemeMode.light;
    }
  }

  var _currentTab = TabItem.tabItems[0];
  final _navigatorKeys = {
    TabItem.tabItems[0]: GlobalKey<NavigatorState>(),
    TabItem.tabItems[1]: GlobalKey<NavigatorState>(),
    TabItem.tabItems[2]: GlobalKey<NavigatorState>(),
    TabItem.tabItems[3]: GlobalKey<NavigatorState>(),
    TabItem.tabItems[4]: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  bottomSheetForSignIn(BuildContext context) {
    

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        context: context,
       // transitionAnimationController: controller,
        enableDrag: false,
        builder: (context) {
          return const CreateScreen();
        });
  }

  void _openCreateScreen() {
    bottomSheetForSignIn(context);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => const CreateScreen(),
    //         fullscreenDialog: false));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.tabItems[0]) {
            // select 'main' tab
            _selectTab(TabItem.tabItems[0]);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Consumer(
        builder: (context, ref, child) {
          final theme = ref.watch(themeModeProvider);

          return Scaffold(
            // appBar: AppBar(
            //   actions: [
            //     IconButton(
            //       onPressed: () {
            //         ref.read(themeModeProvider.notifier).state =
            //             theme == ThemeMode.light
            //                 ? ThemeMode.dark
            //                 : ThemeMode.light;
            //       },
            //       icon: Icon(theme == ThemeMode.dark
            //           ? Icons.light_mode
            //           : Icons.dark_mode),
            //     ),
            //   ],
            // ),
            floatingActionButton: Container(
              padding: const EdgeInsets.only(top: 45),
              height: 125,
              width: 65,
              child: FloatingActionButton(
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                highlightElevation: 0,
                onPressed: _openCreateScreen,
                elevation: 0.0,
                child: Image.asset('assets/images/AddButtonIcon.png'),
              ),
            ),
            body: Stack(children: <Widget>[
              _buildOffstageNavigator(TabItem.tabItems[0]),
              _buildOffstageNavigator(TabItem.tabItems[1]),
              _buildOffstageNavigator(TabItem.tabItems[2]),
              _buildOffstageNavigator(TabItem.tabItems[3]),
              _buildOffstageNavigator(TabItem.tabItems[4]),
            ]),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigation(
                currentTab: _currentTab,
                onSelectTab: _selectTab,
                theme: ref.read(themeModeProvider.notifier).state),
          );
        },
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
