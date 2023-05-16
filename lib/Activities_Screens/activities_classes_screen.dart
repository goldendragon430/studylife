import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '../Widgets/loaderIndicator.dart';
import '../Widgets/custom_snack_bar.dart';
import '../Extensions/extensions.dart';
import '../Networking/subject_service.dart';
import 'package:dio/dio.dart';

import '../../app.dart';
import '../Models/API/subject.dart';
import '.././Models/class_datasource.dart';
import '../Home_Screens/class_details_screen.dart';
import '../Widgets/ClassWidgets/class_widget.dart';

class ActivitiesClassesScreen extends StatefulWidget {
  const ActivitiesClassesScreen({super.key});

  @override
  State<ActivitiesClassesScreen> createState() =>
      _ActivitiesClassesScreenState();
}

class _ActivitiesClassesScreenState extends State<ActivitiesClassesScreen> {
  final List<ClassSubject> _durations = ClassSubject.subjects;
  String selectedSubject = ClassSubject.subjects.first.title;
  final List<ClassStatic> _classes = ClassStatic.classes;


  List<Subject> _subjects = [];


  int _page = 1;
  final int _limit = 20;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;

  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration.zero, () {
  //     _getSubjects();
  //   });
  //  // _controller = ScrollController()..addListener(_loadMore);
  
  // }

  // API

  //   void _getSubjects() async {

  //   LoadingDialog.show(context);

  //   try {
  //     var subjectsResponse =
  //         await SubjectService().getSubjects();

  //         print("SUBJECtS $subjectsResponse");

  //     if (!context.mounted) return;

  //     LoadingDialog.hide(context);

      
  //   } catch (error) {
  //     LoadingDialog.hide(context);
  //     if (error is DioError) {
  //       LoadingDialog.hide(context);
  //       // CustomSnackBar.show(
  //       //     context, CustomSnackBarType.error, error.response?.data['message']);
  //     } else {
  //       LoadingDialog.hide(context);
  //       CustomSnackBar.show(
  //           context, CustomSnackBarType.error, "Oops, something went wrong");
  //     }
  //   }
  // }

  void _selectedCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ClassDetailsScreen(),
            fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return Stack(
        children: [
          Container(
            height: 45,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
            decoration: BoxDecoration(
              color:
                  theme == ThemeMode.light ? Colors.transparent : Colors.black,
              border: Border.all(
                width: 1,
                color: theme == ThemeMode.dark
                    ? Colors.transparent
                    : Colors.black.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  value: selectedSubject,
                  onChanged: (String? newValue) =>
                      setState(() => selectedSubject = newValue ?? ""),
                  items: _durations
                      .map<DropdownMenuItem<String>>(
                          (ClassSubject durationItem) =>
                              DropdownMenuItem<String>(
                                value: durationItem.title,
                                child: Text(durationItem.title),
                              ))
                      .toList(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ),
          ),
          // Classes
          // Container(
          //   alignment: Alignment.topCenter,
          //   height: double.infinity,
          //   margin: const EdgeInsets.only(top: 84),
          //   child: ListView.builder(
          //       // controller: widget._controller,
          //       itemCount: _classes.length,
          //       itemBuilder: (context, index) {
          //         return ClassWidget(
          //             classItem: _classes[index],
          //             cardIndex: index,
          //             upNext: true,
          //             cardselected: _selectedCard);
          //       }),
          // ),
        ],
      );
    });
  }
}
