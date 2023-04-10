import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:beamer/beamer.dart';

import './bottom_navigation.dart';
import './tab_item.dart';
import 'main.dart';
import 'Home_Screens/create_screen.dart';
import './Utilities/constants.dart';
import './Home_Screens/home_page.dart';
import 'Home_Screens/create_screen.dart';
import './Home_Screens/class_details_screen.dart';
import './Controllers/auth_controller.dart';
import './Router/routes.dart';
import './Controllers/auth_notifier.dart';
import './Onboarding_Screens/forgot_password.dart';
import './Widgets/custom_snack_bar.dart';
import './Services/navigation_service.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  var brightness = WidgetsBinding.instance.window.platformBrightness;

  if (brightness == Brightness.dark) {
    return ThemeMode.dark;
  } else {
    return ThemeMode.light;
  }
});

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends ConsumerStatefulWidget {
  App({super.key});

  @override
  ConsumerState<App> createState() => AppState();
}

class AppState extends ConsumerState<App>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late final _routerDelegate;

  @override
  void initState() {
    super.initState();
    _routerDelegate = BeamerDelegate(
      guards: [
        /// if the user is authenticated
        /// else send them to /login
        BeamGuard(
            pathPatterns: ['/home'],
            check: (context, state) {
              final container =
                  ProviderScope.containerOf(context, listen: false);
              return container.read(authProvider).status ==
                  AuthStatus.authenticated;
            },
           beamToNamed: (_, __) => '/login'),

        /// if the user is anything other than authenticated
        /// else send them to /home
        BeamGuard(
            pathPatterns: ['/login'],
            check: (context, state) {
              final container =
                  ProviderScope.containerOf(context, listen: false);
              return container.read(authProvider).status !=
                  AuthStatus.authenticated;
            },
            beamToNamed: (_, __) => '/home'),
      ],
      initialPath: '/started',
      locationBuilder: (routeInformation, _) =>
          BeamerLocations(routeInformation),
          
    );
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

 

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeModeProvider);
    // final signInState = ref.watch(loginStateProvider);

    final signInState = ref.watch(authProvider);
    print("object ${signInState.status}");

    return BeamerProvider(
      routerDelegate: _routerDelegate,
      child: MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Constants.kToLight, brightness: Brightness.light),
        darkTheme: ThemeData(
            primarySwatch: Constants.kToDark, brightness: Brightness.dark),
        themeMode: theme,
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
        backButtonDispatcher: BeamerBackButtonDispatcher(
          delegate: _routerDelegate,
        ),
      ),
    );
  }
}
