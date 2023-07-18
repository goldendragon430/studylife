import 'package:flutter/material.dart';
import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app.dart';

class SubscriptionFeatureCard extends ConsumerWidget {
  final String title;
  final String subtitle;
  const SubscriptionFeatureCard(this.title, this.subtitle, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Container(
    //  margin: EdgeInsets.only(left: 30, right: 20),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/images/CheckMarkBlue.png'),
              Container(
                width: 15,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: theme == ThemeMode.light
                        ? Constants.lightThemeTextSelectionColor
                        : Colors.white),
              ),
            ],
          ),
          Container(
            height: 8,
          ),
          Container(
            margin: EdgeInsets.only(left: 38),
            child: Text(
              subtitle,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                  color: theme == ThemeMode.light
                      ? Constants.lightThemeTextSelectionColor.withOpacity(0.7)
                      : Colors.white.withOpacity(0.7)),
            ),
          )
        ],
      ),
    );
  }
}
