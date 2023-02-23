import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';


import '../app.dart';
import '../login_state.dart';
import '../Utilities/constants.dart';
import '../Widgets/regular_teztField.dart';
import '../Utilities/constants.dart';
import '../Widgets/rounded_elevated_button.dart';
import '../Controllers/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login(BuildContext context, WidgetRef ref) {
      ref.read(loginStateProvider).loggedIn = true;
     // context.beamToNamed('/login');
      //context.go(Constants.homeRouteName);

  }
  void _forgotPassword() {}

   void saveLoginState(BuildContext context) {
   // final themeasd = ref.read(provider)
  //  Provider.of<LoginState>(context, listen: false).loggedIn = true;

  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    // double screenWidth = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).padding.top;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
        backgroundColor: Colors.transparent,
       // surfaceTintColor: Colors.transparent,
       foregroundColor: theme == ThemeMode.light ? Colors.black : Colors.white,
        shadowColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          '',
        ),
      ),

        body: Container(
      color: theme == ThemeMode.light
          ? Colors.white
          : Constants.darkThemeBackgroundColor,
      child: theme == ThemeMode.light
          ? Stack(
              // Light Theme
              children: [
                Image.asset("assets/images/LoginSignupBackground.png"),
                Container(
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  margin:  EdgeInsets.only(top: (height + 133)),
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(45.0),
                        topLeft: Radius.circular(45.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          5.0, // Move to right 5  horizontally
                          5.0, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 52),
                        height: 28,
                        child: Text(
                          'Log In with Email',
                          style: Constants.lightThemeTitleTextStyle,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 132, left: 39, right: 38),
                        child: Column(
                          children: [
                            RegularTextField("Your email", (value) {
                              FocusScope.of(context).unfocus();
                            }, TextInputType.emailAddress, emailController,
                                false),
                            RegularTextField("New Password", (value) {
                              FocusScope.of(context).unfocus();
                            }, TextInputType.visiblePassword,
                                passwordController, false),
                            RoundedElevatedButton(
                                () => _login(context, ref),
                                "Log In",
                                Constants.lightThemePrimaryColor,
                                Colors.black,
                                45),
                          ],
                        ),
                      ),
                      Container(
                         alignment: Alignment.topCenter,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 326),
                        child:  TextButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                onPressed: _forgotPassword,
                                child: Text(
                                  "Forgot Password?",
                                  style: Constants.lightThemeTextButtonTextStyle
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Stack(
              // Dark Theme
              children: [
                Image.asset("assets/images/LoginSignupBackgroundDark.png"),
                Container(
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 133),
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Constants.darkThemeSecondaryBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(45.0),
                        topLeft: Radius.circular(45.0)),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          5.0, // Move to right 5  horizontally
                          5.0, // Move to bottom 5 Vertically
                        ),
                      )
                    ],
                  ),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 52),
                        height: 28,
                        child: Text(
                          'Log In with Email',
                          style: Constants.darkThemeTitleTextStyle,
                        ),
                      ),
                       Container(
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 132, left: 39, right: 38),
                        child: Column(
                          children: [
                            RegularTextField("Your email", (value) {
                              FocusScope.of(context).unfocus();
                            }, TextInputType.emailAddress, emailController,
                                true),
                            RegularTextField("New Password", (value) {
                              FocusScope.of(context).unfocus();
                            }, TextInputType.visiblePassword,
                                passwordController, true),
                            RoundedElevatedButton(
                                () => _login,
                                "Log In",
                                Constants.darkThemePrimaryColor,
                                Colors.black,
                                45),
                          ],
                        ),
                      ),
                        Container(
                         alignment: Alignment.topCenter,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 326),
                        child:  TextButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                onPressed: _forgotPassword,
                                child: Text(
                                  "Forgot Password?",
                                  style: Constants.darkThemeTextButtonTextStyle
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    ));
  }
}


