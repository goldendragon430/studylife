import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app.dart';
import '../../Utilities/constants.dart';
import './rounded_elevated_button.dart';

class AddPhotoWidget extends StatefulWidget {
  const AddPhotoWidget({super.key});

  @override
  State<AddPhotoWidget> createState() => _AddPhotoWidgetState();
}

class _AddPhotoWidgetState extends State<AddPhotoWidget> {
  void _uploadPhoto() {}

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Photo',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeSubtitleTextStyle
                      : Constants.darkThemeSubtitleTextStyle,
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 14,
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: MaterialButton(
                    padding: EdgeInsets.all(2.0),
                    splashColor: Colors.transparent,
                    elevation: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        image: theme == ThemeMode.light
                            ? const DecorationImage(
                                image: AssetImage(
                                    'assets/images/AddPhotoBackgroundImage.png'),
                                fit: BoxFit.cover)
                            : const DecorationImage(
                                image: AssetImage(
                                    'assets/images/AddPhotoBackgroundImageDarkTheme.png'),
                                fit: BoxFit.cover),
                      ),
                      // child: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("SIGN OUT"),
                      // ),
                    ),
                    // ),
                    onPressed: () {
                      print('Tapped');
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                ),
                Container(
                  width: 174,
                  height: 32,
                  child: Text(
                    'Personalize with a photo of your choice',
                    maxLines: 2,
                    style: theme == ThemeMode.light
                        ? Constants.lightThemePhotoDescriptionStyle
                        : Constants.darkThemePhotoDescriptionStyle,
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: 144,
                  height: 44,
                  child: RoundedElevatedButton(_uploadPhoto, "+ Upload Photo",
                      theme == ThemeMode.light ? Constants.lightThemePrimaryColor : Constants.lightThemePrimaryColor, Colors.black, 34),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
