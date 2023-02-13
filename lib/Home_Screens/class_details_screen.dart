import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';

import '../../app.dart';
import '../Widgets/class_exam_details_info_card.dart';
import '../Widgets/icon_label_details_row.dart';

class ClassDetailsScreen extends ConsumerWidget {
  const ClassDetailsScreen({super.key});

  void _editButtonPressed() {}

  void _closeButtonPressed() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Container(
      color: theme == ThemeMode.light ? Constants.lightThemeBackgroundColor : Constants.darkThemeBackgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 206,
            alignment: Alignment.topCenter,
            child: Image.asset("assets/images//ClassExamBackgroundImage.png"),
          ),
          Container(
            height: 36,
            width: 75,
            margin: const EdgeInsets.only(left: 20, top: 50),
            child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    )),
                    minimumSize:
                        MaterialStateProperty.all(const Size((75), 45)),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(const TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
                onPressed: _editButtonPressed,
                child: Text("Edit")),
          ),
          Positioned(
            right: -10,
            top: 45,
            child: MaterialButton(
              splashColor: Colors.transparent,
              elevation: 0.0,
              // ),
              onPressed: _closeButtonPressed,
              child: Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/CloseButtonX.png'),
                        fit: BoxFit.fill)),
              ),
            ),
          ),
           ClassExamDetailsInfoCard(Colors.red, "Class", "Chemistry", "Redox Reactions", DateTime.now(), DateTime.now()),
           Container(
            margin: const EdgeInsets.only(left: 20, top: 349),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               IconLabelDetailsRow(Image.asset("assets/images/LocationPinGrey.png"), "Where", "Room 5, Block D"),
              ],
             ),
           ),
        ],
      ),
    );
  }
}
