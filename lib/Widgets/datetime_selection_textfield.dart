import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app.dart';
import '../Utilities/constants.dart';

class DateTimeSelectionTextField extends ConsumerWidget {
  final TextEditingController textController;
  final String hintText;
  final Function tappedOnTextField;
  const DateTimeSelectionTextField(this.hintText, this.tappedOnTextField, {super.key, required this.textController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final theme = ref.watch(themeModeProvider);

    return Container(
      child: TextField(
        readOnly: true,
        onTap: () => tappedOnTextField(),

        textInputAction: TextInputAction.next,
        cursorColor: theme == ThemeMode.dark
            ? Colors.white.withOpacity(0.2)
            : Colors.black.withOpacity(0.2),
        decoration: InputDecoration(
          filled: true,
          fillColor:
              theme == ThemeMode.dark ? Colors.black.withOpacity(0.2) : Colors.transparent,
              enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme == ThemeMode.dark
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
              focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme == ThemeMode.dark
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme == ThemeMode.dark
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
              color: theme == ThemeMode.dark
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.2)),
          contentPadding: const EdgeInsets.only(left: 20.0),
        ),
        style: theme == ThemeMode.dark
            ? Constants.roboto15DarkThemeTextStyle
            : Constants.roboto15LightThemeTextStyle,
        controller: textController,
      ),
    );
  }
}