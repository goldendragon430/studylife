import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app.dart';

class ChooseNewTimeButton extends ConsumerWidget {
  final VoidCallback selectHandler;

  const ChooseNewTimeButton(this.selectHandler, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Container(
      height: 47,
      margin: const EdgeInsets.only(top: 4, bottom: 4, left: 40, right: 40),
      child: Stack(
        children: [
          ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0.0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(
                    width: 1.0,
                    color: theme == ThemeMode.dark
                        ? Colors.transparent
                        : Colors.black.withOpacity(0.2)),
              )),
              minimumSize: MaterialStateProperty.all(
                  const Size((double.infinity - 60), 45)),
              backgroundColor: MaterialStateProperty.all(theme == ThemeMode.dark
                  ? Colors.black.withOpacity(0.2)
                  : Colors.transparent),
              foregroundColor: MaterialStateProperty.all(theme == ThemeMode.dark
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.2)),
              textStyle: MaterialStateProperty.all(
                TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: theme == ThemeMode.dark
                        ? Colors.white.withOpacity(0.2)
                        : Colors.black.withOpacity(0.2)),
              ),
            ),
            onPressed: selectHandler,
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text("New Time"),
            ),
          ),
          Positioned(
            right: 20,
            top: 10,
            // bottom: 6,
            child: theme == ThemeMode.light
                ? Image.asset("assets/images/LightThemeArrowRight.png")
                : Image.asset("assets/images/DarkThemeArrowRight.png"),
          ),
        ],
      ),
    );
  }
}

class EditTimesAndDaysButton extends ConsumerWidget {
  final VoidCallback selectHandler;
  final String? time;
  final String? days;

  const EditTimesAndDaysButton(this.selectHandler, this.time, this.days,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Container(
      height: 74,
      margin: const EdgeInsets.only(top: 4, bottom: 4, left: 40, right: 40),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
                width: 1.0,
                color: theme == ThemeMode.dark
                    ? Colors.transparent
                    : Colors.black.withOpacity(0.2)),
          )),
          minimumSize:
              MaterialStateProperty.all(const Size((double.infinity - 60), 72)),
          backgroundColor: MaterialStateProperty.all(theme == ThemeMode.dark
              ? Colors.black.withOpacity(0.2)
              : Colors.transparent),
          foregroundColor: MaterialStateProperty.all(theme == ThemeMode.dark
              ? Colors.white.withOpacity(0.2)
              : Colors.black.withOpacity(0.2)),
          textStyle: MaterialStateProperty.all(
            TextStyle(
                fontFamily: "Roboto",
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: theme == ThemeMode.dark
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.2)),
          ),
        ),
        onPressed: selectHandler,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                time != null ? time! : "",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: theme == ThemeMode.dark ? Colors.white : Colors.black,
                ),
              ),
            ),
            Container(
              height: 8,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                days != null ? days! : "",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: theme == ThemeMode.dark
                      ? Colors.white.withOpacity(0.2)
                      : Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
