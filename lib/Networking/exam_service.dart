import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';

import '../Models/API/exam.dart';

class ExamService {
  static ExamService? _instance;

  factory ExamService() => _instance ??= ExamService._();

  ExamService._();

  Future<Response> getExams(int? subjectID, String? filter) async {
    Map<String, dynamic> queryParameters = {};

    if (subjectID != null) {
      final subjectFilter = <String, int>{"subject": subjectID};

      queryParameters.addEntries(subjectFilter.entries);
    }

    if (filter != null) {
      final subjectFilter = <String, String>{"filter": filter};

      queryParameters.addEntries(subjectFilter.entries);
    }

    var response =
        await Api().dio.get("/api/exam", queryParameters: queryParameters);

    return response;
  }

  Future<Response> createExam(Exam examItem) async {
    String body;

    body = jsonEncode({
      'subjectId': examItem.subject?.id ?? 0,
      'module': examItem.module,
      'mode': examItem.mode,
      'room': examItem.room,
      // 'building': examItem.building,
      //'teacher': examItem.teacher,
      //'occurs': examItem.occurs,
      'startTime': examItem.startTime,
      'startDate': examItem.startDate,
      'type': examItem.type,
      'duration': examItem.duration,
      'onlineUrl': examItem.onlineUrl
    }..removeWhere((dynamic key, dynamic value) => value == null));

    var response = await Api().dio.post('/api/exam', data: body);
    print(response);

    return response;
  }

  Future<Response> updateExam(Exam examItem) async {
    String body;

    body = jsonEncode({
      'subjectId': examItem.subject?.id ?? 0,
      'module': examItem.module,
      'mode': examItem.mode,
      'room': examItem.room,
      'building': examItem.building,
      'teacher': examItem.teacher,
      'occurs': examItem.occurs,
      'startTime': examItem.startTime,
      'startDate': examItem.startDate,
      'type': examItem.type,
      'duration': examItem.duration,
      'onlineUrl': examItem.onlineUrl
    }..removeWhere((dynamic key, dynamic value) => value == null));

    var response = await Api().dio.put('/api/exam/${examItem.id}', data: body);
    print(response);

    return response;
  }

  Future<Response> pinExam(int examItemId, bool pinned) async {
    String body;

    body = jsonEncode({
      'pinned': pinned,
    });

    var response = await Api().dio.put('/api/exam/$examItemId/pin', data: body);
    print(response);

    return response;
  }

  Future<Response> addExamScore(
      int examItemId, String score, String scoreType) async {
    String body;

    body = jsonEncode({'score': score, 'scoreType': scoreType});

    var response =
        await Api().dio.put('/api/exam/$examItemId/score', data: body);
    print(response);

    return response;
  }

  Future<Response> deleteExam(int examId) async {
    var response = await Api().dio.delete('/api/exam/$examId');

    return response;
  }
}
