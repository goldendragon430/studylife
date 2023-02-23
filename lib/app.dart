import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:my_study_life_flutter/login_state.dart';

import './bottom_navigation.dart';
import './tab_item.dart';
import './tab_navigator.dart';
import 'main.dart';
import 'Home_Screens/create_screen.dart';
import './Utilities/constants.dart';
import './Home_Screens/home_page.dart';
import 'Home_Screens/create_screen.dart';
import './Home_Screens/class_details_screen.dart';
import './Controllers/auth_controller.dart';
import './Router/routes.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  var brightness = WidgetsBinding.instance.window.platformBrightness;

  if (brightness == Brightness.dark) {
    return ThemeMode.dark;
  } else {
    return ThemeMode.light;
  }
});

class App extends ConsumerStatefulWidget {
 App({super.key});

  @override
  ConsumerState<App> createState() => AppState();
}

class AppState extends ConsumerState<App>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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

    static final navigationBarRouterDelegate = BeamerDelegate(
    initialPath: '/home',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '*': (context, state, data) =>  const ScaffoldWithBottomNavBar(),
      },
    ),
  );

     static final loginRouterDelegate = BeamerDelegate(
    initialPath: '/get_started',
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [OnboardingLocation()],
    ),
    notFoundRedirectNamed: '/get_started',
  );

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeModeProvider);
    final signInState = ref.watch(loginStateProvider);
    print("object ${signInState.loggedIn}");

  return MaterialApp.router(
      debugShowCheckedModeBanner: false,
         theme: ThemeData(
          primarySwatch: Constants.kToLight, brightness: Brightness.light),
      darkTheme: ThemeData(
          primarySwatch: Constants.kToDark, brightness: Brightness.dark),
      themeMode: theme,
      routerDelegate: signInState.loggedIn ? navigationBarRouterDelegate : loginRouterDelegate,
      routeInformationParser: BeamerParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: signInState.loggedIn ? navigationBarRouterDelegate : loginRouterDelegate,
      ),
    );


    // return MaterialApp.router(
    //   // routeInformationParser: router.router.routeInformationParser,
    //   // routerDelegate: router.router.routerDelegate,
    //   routerConfig: router,
    //   debugShowCheckedModeBanner: false,
    //   title: '',
    //   theme: ThemeData(
    //       primarySwatch: Constants.kToLight, brightness: Brightness.light),
    //   darkTheme: ThemeData(
    //       primarySwatch: Constants.kToDark, brightness: Brightness.dark),
    //   themeMode: theme,
    //   // home: signInState.isSignedIn == true ? const App() : ForgotPasswordScreen(),
    //   //  home: const App(),
    // );
    // return WillPopScope(
    //   onWillPop: () async {
    //     final isFirstRouteInCurrentTab =
    //         !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
    //     if (isFirstRouteInCurrentTab) {
    //       // if not on the 'main' tab
    //       if (_currentTab != TabItem.tabItems[0]) {
    //         // select 'main' tab
    //         _selectTab(TabItem.tabItems[0]);
    //         // back button handled by app
    //         return false;
    //       }
    //     }
    //     // let system handle back button if we're on the first route
    //     return isFirstRouteInCurrentTab;
    //   },
    // return Consumer(
    //     builder: (context, ref, child) {

    //       final theme = ref.watch(themeModeProvider);
    //       return Scaffold(
    //         // appBar: AppBar(
    //         //   actions: [
    //         //     IconButton(
    //         //       onPressed: () {
    //         //         ref.read(themeModeProvider.notifier).state =
    //         //             theme == ThemeMode.light
    //         //                 ? ThemeMode.dark
    //         //                 : ThemeMode.light;
    //         //       },
    //         //       icon: Icon(theme == ThemeMode.dark
    //         //           ? Icons.light_mode
    //         //           : Icons.dark_mode),
    //         //     ),
    //         //   ],
    //         // ),
    //         floatingActionButton: Container(
    //           padding: const EdgeInsets.only(top: 45),
    //           height: 125,
    //           width: 65,
    //           child: FloatingActionButton(
    //             foregroundColor: Colors.transparent,
    //             backgroundColor: Colors.transparent,
    //             highlightElevation: 0,
    //             onPressed: _openCreateScreen,
    //             elevation: 0.0,
    //             child: Image.asset('assets/images/AddButtonIcon.png'),
    //           ),
    //         ),
    //         body: Stack(children: <Widget>[
    //           _buildOffstageNavigator(TabItem.tabItems[0]),
    //           _buildOffstageNavigator(TabItem.tabItems[1]),
    //           _buildOffstageNavigator(TabItem.tabItems[2]),
    //           _buildOffstageNavigator(TabItem.tabItems[3]),
    //           _buildOffstageNavigator(TabItem.tabItems[4]),
    //         ]),
    //         floatingActionButtonLocation:
    //             FloatingActionButtonLocation.centerDocked,
    //         bottomNavigationBar: BottomNavigation(
    //             currentTab: _currentTab,
    //             onSelectTab: _selectTab,
    //             theme: ref.read(themeModeProvider.notifier).state),
    //       );
    //     },
    // );
  }
}
