import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';
import '../Networking/user_service.dart';
import 'package:dio/dio.dart';
import '../Services/repository.dart';
import '../Models/user.model.dart';

import '../app.dart';
import '../login_state.dart';
import '../Utilities/constants.dart';
import '../Widgets/regular_teztField.dart';
import '../Utilities/constants.dart';
import '../Widgets/rounded_elevated_button.dart';
import '../Controllers/auth_controller.dart';
import '../Controllers/auth_notifier.dart';
import '../Widgets/loaderIndicator.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
   // showKeyboard();
  }

  @override
  void dispose() {
        FocusScope.of(context).unfocus();

      focusNode.dispose();
    super.dispose();
  }

  // void _login(BuildContext context, WidgetRef ref) {
  void _forgotPassword(BuildContext context) {
    context.beamToNamed('/started/login/forgot_password');
  }

  void saveLoginState(BuildContext context) {
    // final themeasd = ref.read(provider)
    //  Provider.of<LoginState>(context, listen: false).loggedIn = true;
  }

  void showKeyboard() {
  focusNode.requestFocus();
}

void dismissKeyboard() {
  focusNode.unfocus();
}

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final theme = ref.watch(themeModeProvider);
        // double screenWidth = MediaQuery.of(context).size.width;
        var height = MediaQuery.of(context).padding.top;

        return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor:
                  theme == ThemeMode.light ? Colors.black : Colors.white,
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
                          margin: EdgeInsets.only(top: (height + 160)),
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
                                height: double.infinity,
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                    top: 132, left: 39, right: 38),
                                child: Column(
                                  children: [
                                    RegularTextField(
                                      "Your email",
                                      (value) {
                                        FocusScope.of(context).nextFocus();
                                      },
                                      TextInputType.emailAddress,
                                      emailController,
                                      false,
                                      autofocus: true,
                                      focusNode: focusNode,
                                    ),
                                    RegularTextField(
                                      "Password",
                                      (value) {
                                        FocusScope.of(context).unfocus();
                                      },
                                      TextInputType.visiblePassword,
                                      passwordController,
                                      false,
                                      autofocus: false,
                                    ),
                                    RoundedElevatedButton(() async {
                                      LoadingDialog.show(context);
                                      //loginUser("stoiljkovicmladen@gmail.com", "12312");

                                      await ref
                                          .read(authProvider.notifier)
                                          .loginUser(
                                              "stoiljkovicmladen@gmail.com",
                                              "12312");
                                      LoadingDialog.hide(context);

                                      // context.beamBack();
                                      Beamer.of(context).update();
                                    },
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
                                child: TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent)),
                                  onPressed: () => _forgotPassword(context),
                                  child: Text("Forgot Password?",
                                      style: Constants
                                          .lightThemeTextButtonTextStyle),
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
                        Image.asset(
                            "assets/images/LoginSignupBackgroundDark.png"),
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
                                    RegularTextField(
                                      "Your email",
                                      (value) {
                                       FocusScope.of(context).nextFocus();
                                      },
                                      TextInputType.emailAddress,
                                      emailController,
                                      true,
                                      autofocus: true,
                                    ),
                                    RegularTextField(
                                      "Password",
                                      (value) {
                                     FocusScope.of(context).unfocus();
                                      },
                                      TextInputType.visiblePassword,
                                      passwordController,
                                      true,
                                      autofocus: false,
                                    ),
                                    RoundedElevatedButton(() async {
                                      await ref
                                          .read(authProvider.notifier)
                                          .loginUser(
                                              "stoiljkovicmladen@gmail.com",
                                              "123123");
                                      context.beamBack();
                                      Beamer.of(context).update();
                                    },
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
                                child: TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent)),
                                  onPressed: () => _forgotPassword(context),
                                  child: Text("Forgot Password?",
                                      style: Constants
                                          .darkThemeTextButtonTextStyle),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ));
      },
    );
  }
}
