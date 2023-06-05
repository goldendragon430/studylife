import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';
import '../Models/API/classmodel.dart';

class ClassService {
  static ClassService? _instance;

  factory ClassService() => _instance ??= ClassService._();

  ClassService._();

  Future<Response> getClasses(int? subjectID) async {
    var response = await Api().dio.get("/api/class");

    return response;
  }

  Future<Response> createClass(ClassModel classItem) async {
    String body;

    body = jsonEncode({
      'subjectId': classItem.subject?.id ?? 0,
      'module': classItem.module,
      'mode' : classItem.mode,
      'room': classItem.room,
      'building': classItem.building,
      'teacher': classItem.teacher,
      'occurs': classItem.occurs,
      'days': classItem.days,
      'startTime': classItem.startTime,
      'endTime': classItem.endTime,
      'startDate': classItem.startDate,
      // "days": classItem.days,

    }..removeWhere((dynamic key, dynamic value) => value == null));

    var response = await Api().dio.post(
        '/api/class',
        data: body);

    return response;
  }
}
