import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import './app.dart';
import './Utilities/constants.dart';
import 'Onboarding_Screens/get_started.dart';
import './Controllers/auth_controller.dart';
import './Onboarding_Screens/signup.dart';
import './Onboarding_Screens/login.dart';
import './Onboarding_Screens/forgot_password.dart';
import './Home_Screens/home_page.dart';

void main() {
    runApp(const ProviderScope(child: MyStudyLife()));
}

class MyStudyLife extends ConsumerWidget {
  const MyStudyLife({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themMode = ref.watch(themeModeProvider);
    final signInState = ref.watch(authControllerProvider);

    return MaterialApp(
      title: 'Flutter Demo',
        theme: ThemeData(
        primarySwatch: Constants.kToLight,
        brightness: Brightness.light
      ),
      darkTheme: ThemeData(
        primarySwatch: Constants.kToDark,
        brightness: Brightness.dark
      ),
      themeMode: themMode,
     // home: signInState.isSignedIn == true ? const App() : ForgotPasswordScreen(),
      home: const App(),

    );
  }
}

