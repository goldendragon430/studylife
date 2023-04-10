import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Widgets/regular_teztField.dart';
import '../app.dart';
import '../Widgets/rounded_elevated_button.dart';

class ChangePasswordScreen extends ConsumerWidget {
  ChangePasswordScreen({super.key});

  final passwordController = TextEditingController();
  final newpasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _savePassword() {}

  void _cancel(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: theme == ThemeMode.light
          ? Constants.lightThemeBackgroundColor
          : Constants.darkThemeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: theme == ThemeMode.light ? Colors.black : Colors.white,
        shadowColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Change Password',
          style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: theme == ThemeMode.light ? Colors.black : Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 138,left: 39, right: 38),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Existing Password',
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 6,
            ),
            RegularTextField("Enter Existing Password", (value) {
              FocusScope.of(context).unfocus();
            }, TextInputType.visiblePassword, passwordController, theme == ThemeMode.dark, autofocus: false,),
             Container(
              height: 6,
            ),
            Text(
              'New Password',
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 6,
            ),
            RegularTextField("Enter New Password", (value) {
              FocusScope.of(context).unfocus();
            }, TextInputType.visiblePassword, passwordController, theme == ThemeMode.dark, autofocus: false,),
             Container(
              height: 6,
            ),
            Text(
              'Confirm New Password',
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 6,
            ),
            RegularTextField("Confirm New Password", (value) {
              FocusScope.of(context).unfocus();
            }, TextInputType.visiblePassword, confirmPasswordController, theme == ThemeMode.dark, autofocus: false,),
            Container(
              height: 20,
            ),
            Container(
              height: 68,
            ),
            Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              // margin: const EdgeInsets.only(top: 260),
              padding: const EdgeInsets.only(left: 73, right: 72),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RoundedElevatedButton(_savePassword, "Change Password",
                      Constants.lightThemePrimaryColor, Colors.black, 45),
                  RoundedElevatedButton(() => _cancel(context), "Cancel",
                      Constants.blueButtonBackgroundColor, Colors.white, 45)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
