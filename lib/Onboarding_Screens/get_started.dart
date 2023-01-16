import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../app.dart';

class GetStarted extends ConsumerWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Scaffold(
      body: Container(

        color: theme == ThemeMode.light ? Colors.white : Colors.black,




        child: theme == ThemeMode.light
            ? Stack(
                // Light Theme
                children: [
                  Image.asset("assets/images/LoginSignupBackground.png")
                ],
              )
            : Stack(
                // Dark Theme
                children: [
                  Image.asset(
                        "assets/images/LoginSignupBackgroundDark.png"),
                ],
              ),
      ),
    );
  }
}
