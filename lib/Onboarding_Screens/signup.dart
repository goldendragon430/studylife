import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app.dart';
import '../Widgets/regular_teztField.dart';
import '../Utilities/constants.dart';
import '../Widgets/rounded_elevated_button.dart';

class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    // double screenWidth = MediaQuery.of(context).size.width;

    void _signUp() {}

    return Scaffold(
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
                  margin: const EdgeInsets.only(top: 133),
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
                          'Sign up with Email',
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
                            RegularTextField("Confirm Password", (value) {
                              FocusScope.of(context).unfocus();
                            }, TextInputType.visiblePassword, confirmController,
                                false),
                            RoundedElevatedButton(
                                _signUp,
                                "Sign up",
                                Constants.lightThemePrimaryColor,
                                Colors.black,
                                45)
                          ],
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
                          'Sign up with Email',
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
                            RegularTextField("Confirm Password", (value) {
                              FocusScope.of(context).unfocus();
                            }, TextInputType.visiblePassword, confirmController,
                                true),
                            RoundedElevatedButton(
                                _signUp,
                                "Sign up",
                                Constants.darkThemePrimaryColor,
                                Colors.black,
                                45)
                          ],
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
