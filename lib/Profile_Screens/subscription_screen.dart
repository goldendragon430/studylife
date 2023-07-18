import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app.dart';
import '../../Utilities/constants.dart';
import '../Widgets/rounded_elevated_button.dart';
import 'dart:ui';
import '../Widgets/ProfileWidgets/subscription_feature_card.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final ScrollController scrollcontroller = ScrollController();

  void _closeButtonPressed(context) {
    Navigator.pop(context);
  }

  void _buttonMonthTapped() {}

  void _buttonYearTapped() {}

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return Container(
        color: theme == ThemeMode.light
            ? Constants.lightThemeClassExamDetailsBackgroundColor
            : Constants.darkThemeBackgroundColor,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ListView.builder(
              controller: scrollcontroller,
              padding: const EdgeInsets.only(top: 0),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Column(children: [
                  if (index == 0) ...[
                    Container(
                      height: 323,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 0),
                            height: 258,
                            width: double.infinity,
                            alignment: Alignment.topCenter,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage(
                                    'assets/images/SubscriptionImageTop.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                height: 270,
                                //   padding: EdgeInsets.only(bottom: -10),
                                decoration: BoxDecoration(
                                  color: Constants.darkThemeBackgroundColor
                                      .withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            height: 260,
                            width: double.infinity,
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: theme == ThemeMode.dark
                                    ? const ExactAssetImage(
                                        'assets/images/DakThemeCoverForBackground.png')
                                    : const ExactAssetImage(
                                        'assets/images/LightThemeBackgroundCover.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                              right: 84,
                              top: 86,
                              child: Image.asset(
                                  'assets/images/SubscriptionAcademicHatIcon.png')),
                          Positioned(
                            right: -10,
                            top: 45,
                            child: MaterialButton(
                              splashColor: Colors.transparent,
                              elevation: 0.0,
                              // ),
                              onPressed: () => _closeButtonPressed(context),
                              child: Container(
                                height: 36,
                                width: 36,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/CloseButtonX.png'),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 256),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Premium Subscription",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold,
                                        color: theme == ThemeMode.light
                                            ? Constants
                                                .lightThemeTextSelectionColor
                                            : Colors.white),
                                  ),
                                ),
                                Container(
                                  height: 8,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Purchase premium to unlock the following features",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.normal,
                                        color: theme == ThemeMode.light
                                            ? Constants
                                                .lightThemeTextSelectionColor
                                                .withOpacity(0.7)
                                            : Colors.white.withOpacity(0.7)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (index == 1) ...[
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25, top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SubscriptionFeatureCard(
                              'Xtra & Personalization',
                              'Track extra-curriculars and one off events using Xtra. Customize your dashboard with personalized images.'),
                          Container(
                            height: 30,
                          ),
                          const SubscriptionFeatureCard('Dark mode',
                              'Access dark mode to make the best use of dim light situations, particularly at night.'),
                          Container(
                            height: 30,
                          ),
                          const SubscriptionFeatureCard(
                              'Xtra & Personalization',
                              'Track extra-curriculars and one off events using Xtra. Customize your dashboard with personalized images.'),
                          Container(
                            height: 30,
                          ),
                          RoundedElevatedButton(
                              _buttonMonthTapped,
                              "1.99/Month*",
                              Constants.lightThemePrimaryColor,
                              Colors.black,
                              45),
                          RoundedElevatedButton(
                              _buttonYearTapped,
                              "9.99/Year*",
                              Constants.blueButtonBackgroundColor,
                              Colors.white,
                              45),
                          Container(
                            height: 30,
                          ),
                          Text(
                            "* Subscriptions will automatically renew and your credit card will be charged at the end of each period, unless you unsubscribe at least 24 hours before.",
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.normal,
                                color: theme == ThemeMode.light
                                    ? Constants.lightThemeTextSelectionColor
                                        .withOpacity(0.7)
                                    : Colors.white.withOpacity(0.7)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ]);
              },
            ),
          ],
        ),
      );
    });
  }
}
