import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';
import '../Models/API/classmodel.dart';
import '../Models/API/rotation_time.dart';

class ClassService {
  static ClassService? _instance;

  factory ClassService() => _instance ??= ClassService._();

  ClassService._();

  Future<Response> getClasses(int? subjectID) async {
    var response = await Api().dio.get("/api/class");

    return response;
  }

  Future<Response> createClass(
      ClassModel classItem, List<RotationTimeSetting> rotationSettings) async {
    String body;
    List<ClassTimeToSend> times = [];

    String? days = null;
    days = classItem.days?.join(",");

    if (rotationSettings.isNotEmpty) {
      for (var rotation in rotationSettings) {
        var classTime = ClassTimeToSend();
        classTime.startTime = rotation.startTime;
        classTime.endTime = rotation.endtime;

        String? daysFormatted = null;
        if (rotation.rotationDaysNormal != null) {
          daysFormatted = rotation.rotationDaysNormal?.join(",");
        }
        if (rotation.rotationDaysLettered != null) {
          daysFormatted = rotation.rotationDaysLettered?.join(",");
        }
        classTime.daysFormatted = daysFormatted;
        classTime.rotationWeek = rotation.rotationWeek ?? 0;
        times.add(classTime);
      }
    }

    body = jsonEncode({
      'subjectId': classItem.subject?.id ?? 0,
      'module': classItem.module,
      'mode': classItem.mode,
      'room': classItem.room,
      'building': classItem.building,
      'teacher': classItem.teacher,
      'occurs': classItem.occurs,
      'days': days,
      'startTime': classItem.startTime,
      'endTime': classItem.endTime,
      'startDate': classItem.startDate,
      'onlineUrl': classItem.onlineUrl,
      'teachersEmail': classItem.teachersEmail,
      'classTimes': times
    }..removeWhere((dynamic key, dynamic value) => value == null));

    var response = await Api().dio.post('/api/class', data: body);

    return response;
  }

  Future<Response> updateClass(
      ClassModel classItem, List<RotationTimeSetting> rotationSettings) async {
    String body;

    List<ClassTimeToSend> times = [];

    String? days = null;
    days = classItem.days?.join(",");

    if (rotationSettings.isNotEmpty) {
      for (var rotation in rotationSettings) {
        var classTime = ClassTimeToSend();
        classTime.startTime = rotation.startTime;
        classTime.endTime = rotation.endtime;

        String? daysFormatted = null;
        if (rotation.rotationDaysNormal != null) {
          daysFormatted = rotation.rotationDaysNormal?.join(",");
        }
        if (rotation.rotationDaysLettered != null) {
          daysFormatted = rotation.rotationDaysLettered?.join(",");
        }
        classTime.daysFormatted = daysFormatted;
        classTime.rotationWeek = rotation.rotationWeek ?? 0;
        times.add(classTime);
      }
    }

    body = jsonEncode({
      'subjectId': classItem.subject?.id ?? 0,
      'module': classItem.module,
      'mode': classItem.mode,
      'room': classItem.room,
      'building': classItem.building,
      'teacher': classItem.teacher,
      'occurs': classItem.occurs,
      'days': days,
      'startTime': classItem.startTime,
      'endTime': classItem.endTime,
      'startDate': classItem.startDate,
      'onlineUrl': classItem.onlineUrl,
      'teachersEmail': classItem.teachersEmail,
      'classTimes': times
    }..removeWhere((dynamic key, dynamic value) => value == null));

    var response =
        await Api().dio.put('/api/class/${classItem.id}', data: body);

    return response;
  }

   Future<Response> deleteClass(int classId) async {
    var response = await Api().dio.delete('/api/class/$classId');

    return response;
  }
}
