import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '../Models/Services/storage_service.dart';
import '../../Widgets/loaderIndicator.dart';
import '../../Widgets/custom_snack_bar.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:io';
import '../Networking/sync_controller.dart';


import '../../app.dart';
import '../Widgets/class_exam_details_info_card.dart';
import '../Widgets/icon_label_details_row.dart';
import '../Models/tasks_due_dataSource.dart';
import '../Widgets/task_due_card.dart';
import '../Widgets/custom_alert.dart';
import './add_exam_score.dart';
import '../Models/API/exam.dart';
import '../Home_Screens/create_screen.dart';
import '../Networking/exam_service.dart';

class ExamDetailsScreen extends StatefulWidget {
  final Exam examItem;
  const ExamDetailsScreen({super.key, required this.examItem});

  @override
  State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {

  final SyncController _syncController = SyncController();

  void _editButtonPressed(BuildContext context) {
    bottomSheetForSignIn(context);
  }

    bottomSheetForSignIn(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        context: context,
        // transitionAnimationController: controller,
        enableDrag: false,
        builder: (context) {
          return CreateScreen(examItem: widget.examItem);
        });
  }

  void _closeButtonPressed(context) {
    Navigator.pop(context);
  }

  void _selectTaskDue(int index) {
    print("CARD SELECTED $index");
  }

  void _addScorePressed(context) {
    bottomSheetForSscore(context);
  }

  bottomSheetForSscore(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        context: context,
        // transitionAnimationController: controller,
        enableDrag: false,
        builder: (context) {
          return const AddScoreScreen();
        });
  }

  // API
  void pinUnpinExam() async {
    final contextMain = scaffoldMessengerKey.currentContext!;
    var examItem = widget.examItem;

    var pinned = examItem.pinned;

    if (pinned != null) {
      pinned = !pinned;
    }

    LoadingDialog.show(context);

     try {
        var response = await ExamService().pinExam(examItem.id ?? 0, pinned ?? false);
        var sync = await _syncController.syncAll();

        print("EOOO GAAAA $response");

        if (!contextMain.mounted) return;

        LoadingDialog.hide(context);
        CustomSnackBar.show(contextMain, CustomSnackBarType.success,
            response.data['message'], true);
        Navigator.pop(context);
      } catch (error) {
        if (error is DioError) {
          LoadingDialog.hide(context);
          CustomSnackBar.show(contextMain, CustomSnackBarType.error,
              error.response?.data['message'], true);
        } else {
          LoadingDialog.hide(context);
          CustomSnackBar.show(contextMain, CustomSnackBarType.error,
              "Oops, something went wrong", true);
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {

    final theme = ref.watch(themeModeProvider);
    final List<TaskDueStatic> _tasksDue = TaskDueStatic.tasksDue;

    return Container(
      color: theme == ThemeMode.light
          ? Constants.lightThemeClassExamDetailsBackgroundColor
          : Constants.darkThemeBackgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
           Container(
            height: 206,
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Image.network(
              widget.examItem.subject?.imageUrl ?? "",
              fit: BoxFit.fill,
              height: 206,
              width: double.infinity,
            ),
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
                onPressed: () => _editButtonPressed(context),
                child: Text("Edit")),
          ),
          Container(
             height: 36,
            width: 80,
             margin: const EdgeInsets.only(left: 107, top: 50),

            child: ElevatedButton.icon(
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
              onPressed: () => pinUnpinExam(),
              icon: Image.asset('assets/images/PinIconWhite.png'),
              label: Text('Pin'),
            ),
          ),
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
                        image: AssetImage('assets/images/CloseButtonX.png'),
                        fit: BoxFit.fill)),
              ),
            ),
          ),
          ClassExamDetailsInfoCard(widget.examItem.subject?.colorHex != null
                              ? HexColor.fromHex(widget.examItem.subject!.colorHex!)
                              :Colors.blue, "Exam", widget.examItem.subject?.subjectName ?? "",
              widget.examItem.module ?? "", widget.examItem.startDate, widget.examItem.startTime),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 349),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SeatIconGrey,
                // DurationIconGrey

                IconLabelDetailsRow(
                    Image.asset("assets/images/DurationIconGrey.png"),
                    "Duration",
                    "${widget.examItem.duration} Minutes"),
                Container(
                  height: 8,
                ),
                IconLabelDetailsRow(
                    Image.asset("assets/images/SeatIconGrey.png"),
                    "Seat",
                    widget.examItem.seat ?? ""),
                Container(
                  height: 8,
                ),
                IconLabelDetailsRow(
                    Image.asset("assets/images/LocationPinGrey.png"),
                    "Where",
                    "${widget.examItem.room}"),
                Container(
                  height: 30,
                ),
                Container(
                  height: 71,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: theme == ThemeMode.light
                        ? Constants.lightThemeAddScoreBackgroundColor
                        : Constants.darkThemeAddScoreBackgroundColor,
                    border: Border.all(
                      color: theme == ThemeMode.light
                          ? Constants.lightThemeAddScoreBackgroundColor
                          : Constants.darkThemeAddScoreBackgroundColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => _addScorePressed(context),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0.0),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          )),
                          minimumSize:
                              MaterialStateProperty.all(const Size(142, 34)),
                          backgroundColor: theme == ThemeMode.light
                              ? MaterialStateProperty.all(
                                  Constants.lightThemePrimaryColor)
                              : MaterialStateProperty.all(
                                  Constants.darkThemePrimaryColor),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))),
                      child: const Text(
                        '+ Add Score',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 24,
                ),
                Text(
                  'Revision Tasks',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextStyle,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 567),
            child: ListView.builder(
                // controller: widget._controller,
                itemCount: _tasksDue.length,
                itemBuilder: (context, index) {
                  return TaskDueCardForClassOrExam(
                    index,
                    _tasksDue[index],
                    _selectTaskDue,
                  );
                }),
          ),
        ],
      ),
    );
  });
  }
}
