import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:beamer/beamer.dart';

import '../app.dart';
import '../Utilities/constants.dart';
import '../Widgets/social_login_widget.dart';
import '../Widgets/rounded_elevated_button.dart';
import './login.dart';
import '../Controllers/auth_notifier.dart';

// Location defining the pages for the first tab
// class OnboardingLocation extends BeamLocation<BeamState> {
//   @override
//   List<String> get pathPatterns => ['/get_started/:login'];

//   @override
//   List<BeamPage> buildPages(BuildContext context, BeamState state) {
//     final pages = [
//       const BeamPage(
//         key: ValueKey('get_started'),
//         title: 'Get Srarted',
//         child: GetStarted(),
//       ),
//       if (state.pathParameters.containsKey('login'))
//         BeamPage(
//           key: ValueKey('login'),
//           title: "login",
//           child: LoginScreen(),
//         ),

//       // BeamPage(
//       //   key: const ValueKey('login'),
//       //   title: 'Login',
//       //   child: LoginScreen(),
//       // ),
//       // BeamPage(
//       //   key: const ValueKey('signup'),
//       //   title: 'Signup',
//       //   child: RegisterScreen(),
//       // ),
//       // BeamPage(
//       //   key: const ValueKey('forgot_password'),
//       //   title: 'Forgot Password',
//       //   child: ForgotPasswordScreen(),
//       // ),
//     ];

//     return pages;
//   }
// }

class GetStarted extends ConsumerWidget {
  const GetStarted({super.key});

  void _appleLogin() {}

  void _facebookLogin() {}

  void _googleLogin() {}

  void _officeLogin() {}

  void _login(BuildContext context, WidgetRef ref) {
        context.beamToNamed('/started/login');
  }

  void _signUp(BuildContext context) {
    context.beamToNamed('/started/signup');
  }

  void _openTermsAndConditions() {}

  // static final loginRouterDelegate = BeamerDelegate(
  //   initialPath: '/get_started',
  //   locationBuilder: BeamerLocationBuilder(
  //     beamLocations: [OnboardingLocation()],
  //   ),
  //   notFoundRedirectNamed: '/get_started',
  // );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    double screenWidth = MediaQuery.of(context).size.width;

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
                    margin: const EdgeInsets.only(top: 170),
                    height: 142,
                    child: Image.asset("assets/images/LogoLightSignup.png"),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 396),
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
                          margin: const EdgeInsets.only(top: 28),
                          height: 28,
                          child: Text(
                            'Get Started',
                            style: Constants.lightThemeTitleTextStyle,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 81),
                          height: 18,
                          child: Text(
                            'Continue with...',
                            style: Constants.roboto15LightThemeTextStyle,
                          ),
                        ),

                        // Social
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 118),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialLoginButton(
                                  _appleLogin,
                                  "Apple",
                                  Image.asset(
                                      "assets/images/AppleLogicIcon.png"),
                                  false),
                              SocialLoginButton(
                                  _facebookLogin,
                                  "Facebook",
                                  Image.asset(
                                      "assets/images/FacebookLoginIcon.png"),
                                  false),
                              SocialLoginButton(
                                  _googleLogin,
                                  "Google",
                                  Image.asset(
                                      "assets/images/GoogleLoginIcon.png"),
                                  false),
                              SocialLoginButton(
                                  _officeLogin,
                                  "Office 365",
                                  Image.asset(
                                      "assets/images/OfficeLoginIcon.png"),
                                  false)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 232),
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Constants.lightThemeDividerColor,
                                height: 0.5,
                                width: (screenWidth / 2) - 50,
                              ),
                              Text(
                                'Or',
                                style: Constants.roboto15LightThemeTextStyle,
                              ),
                              Container(
                                color: Constants.lightThemeDividerColor,
                                height: 0.5,
                                width: (screenWidth / 2) - 50,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 260),
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              RoundedElevatedButton(() => _login(context, ref),
                                  "Log in with email",
                                  Constants.lightThemePrimaryColor,
                                  Colors.black,
                                  45),
                              //  LoginButton(),

                              RoundedElevatedButton(
                                  () => _signUp(context),
                                  "Sign up with email",
                                  Constants.blueButtonBackgroundColor,
                                  Colors.white,
                                  45)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 393, left: 40),
                          // height: 31,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("By continuing you agree to our",
                                  style: Constants
                                      .socialLoginLightButtonTextStyle),
                              TextButton(
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        Colors.transparent),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.transparent)),
                                onPressed: _openTermsAndConditions,
                                child: Text(
                                  "privacy policy & terms of use",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black.withOpacity(0.6),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
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
                    margin: const EdgeInsets.only(top: 170),
                    height: 142,
                    child: Image.asset("assets/images/LogoLightSignup.png"),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 396),
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
                          margin: const EdgeInsets.only(top: 28),
                          height: 28,
                          child: Text(
                            'Get Started',
                            style: Constants.darkThemeTitleTextStyle,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 81),
                          height: 18,
                          child: Text(
                            'Continue with...',
                            style: Constants.roboto15DarkThemeTextStyle,
                          ),
                        ),

                        // Social
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 118),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialLoginButton(
                                  _appleLogin,
                                  "Apple",
                                  Image.asset(
                                      "assets/images/AppleLogicIcon.png"),
                                  true),
                              SocialLoginButton(
                                  _facebookLogin,
                                  "Facebook",
                                  Image.asset(
                                      "assets/images/FacebookLoginIcon.png"),
                                  true),
                              SocialLoginButton(
                                  _googleLogin,
                                  "Google",
                                  Image.asset(
                                      "assets/images/GoogleLoginIcon.png"),
                                  true),
                              SocialLoginButton(
                                  _officeLogin,
                                  "Office 365",
                                  Image.asset(
                                      "assets/images/OfficeLoginIcon.png"),
                                  true)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 232),
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                color: Constants.darkThemeDividerColor,
                                height: 0.5,
                                width: (screenWidth / 2) - 50,
                              ),
                              Text(
                                'Or',
                                style: Constants.roboto15DarkThemeTextStyle,
                              ),
                              Container(
                                color: Constants.darkThemeDividerColor,
                                height: 0.5,
                                width: (screenWidth / 2) - 50,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 260),
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              RoundedElevatedButton(() => _login(context, ref),
                                  "Log in with email",
                                  Constants.darkThemePrimaryColor,
                                  Colors.black,
                                  45),
                              RoundedElevatedButton(
                                  () => _signUp(context),
                                  "Sign up with email",
                                  Constants.blueButtonBackgroundColor,
                                  Colors.white,
                                  45)
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 393, left: 40),
                          // height: 31,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("By continuing you agree to our",
                                  style:
                                      Constants.socialLoginDarkButtonTextStyle),
                              TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent)),
                                  onPressed: _openTermsAndConditions,
                                  child: Text(
                                    "privacy policy & terms of use",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white.withOpacity(0.6),
                                      decoration: TextDecoration.underline,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

// class LoginButton extends ConsumerWidget {
//   const LoginButton({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Container(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: () async {
//           await ref
//               .read(authProvider.notifier)
//               .loginUser("beamer", "supersecret");
//           Beamer.of(context).update();
//         },
//         child: Text('Login'),
//       ),
//     );
//   }
// }
