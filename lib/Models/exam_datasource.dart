
import 'package:flutter/material.dart';

class ExamStatic {
  final String title;
  final String description;
  final DateTime dateFrom;
  final Image subjectImage;
  final int tasksDue;
  final bool upNext;
  final Color subjectColor;
  final Duration duration;
  final String examType;

  Image? classImage;

  ExamStatic({
    required this.title,
    required this.description,
    required this.dateFrom,
    required this.subjectColor,
    required this.subjectImage,
    required this.tasksDue,
    required this.upNext,
    this.classImage,
    required this.duration,
    required this.examType,
  });


     static List<ExamStatic> exams = [
      ExamStatic(title: "Biology", description: "Redox Reactions", dateFrom: DateTime.now().add(Duration(days: 3)), subjectImage: Image.asset('assets/images/BiologyExample.png'), tasksDue: 2, upNext: false, subjectColor: Colors.cyan, duration: Duration(minutes: 60), examType: 'Quiz'),
      ExamStatic(title: "Biology", description: "Redox Reactions", dateFrom: DateTime.now().add(Duration(days: 3)), subjectImage: Image.asset('assets/images/BiologyExample.png'), tasksDue: 2, upNext: false, subjectColor: Colors.cyan, duration: Duration(minutes: 60), examType: 'Quiz'),
      ExamStatic(title: "Biology", description: "Redox Reactions", dateFrom: DateTime.now().add(Duration(days: 3)), subjectImage: Image.asset('assets/images/BiologyExample.png'), tasksDue: 2, upNext: false, subjectColor: Colors.cyan, duration: Duration(minutes: 60), examType: 'Quiz'),
      ExamStatic(title: "Biology", description: "Redox Reactions", dateFrom: DateTime.now().add(Duration(days: 3)), subjectImage: Image.asset('assets/images/BiologyExample.png'), tasksDue: 2, upNext: false, subjectColor: Colors.cyan, duration: Duration(minutes: 60), examType: 'Quiz'),
      ExamStatic(title: "Biology", description: "Redox Reactions", dateFrom: DateTime.now().add(Duration(days: 3)), subjectImage: Image.asset('assets/images/BiologyExample.png'), tasksDue: 2, upNext: false, subjectColor: Colors.cyan, duration: Duration(minutes: 60), examType: 'Quiz'),

  

    ];
}