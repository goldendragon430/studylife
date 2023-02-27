
import 'package:flutter/material.dart';

class ClassStatic {
  final String title;
  final String description;
  final DateTime dateFrom;
  final DateTime dateTo;
  final String subjectImage;
  final int tasksDue;
  final bool upNext;
  final Color subjectColor;

  Image? classImage;

  ClassStatic({
    required this.title,
    required this.description,
    required this.dateFrom,
    required this.dateTo,
    required this.subjectColor,
    required this.subjectImage,
    required this.tasksDue,
    required this.upNext,
    this.classImage
  });


     static List<ClassStatic> classes = [
      ClassStatic(title: "Chemistry", description: "Redox Reactions", dateFrom: DateTime.now(), dateTo: DateTime.now().add(const Duration(hours: 1)), subjectImage: 'assets/images/ChemistryClassImage.png', tasksDue: 2, upNext: false, subjectColor: Colors.red),
            ClassStatic(title: "Chemistry", description: "Redox Reactions", dateFrom: DateTime.now(), dateTo: DateTime.now().add(const Duration(hours: 1)), subjectImage: 'assets/images/ChemistryClassImage.png', tasksDue: 2, upNext: true, subjectColor: Colors.red)
,      ClassStatic(title: "Chemistry", description: "Redox Reactions", dateFrom: DateTime.now().add(Duration(days: 2)), dateTo: DateTime.now().add(const Duration(days: 2, hours: 1)), subjectImage: 'assets/images/ChemistryClassImage.png', tasksDue: 2, upNext: true, subjectColor: Colors.red)
,      ClassStatic(title: "Chemistry", description: "Redox Reactions", dateFrom: DateTime.now(), dateTo: DateTime.now().add(const Duration(hours: 1)), subjectImage: 'assets/images/ChemistryClassImage.png', tasksDue: 2, upNext: true, subjectColor: Colors.red)

    ];
}