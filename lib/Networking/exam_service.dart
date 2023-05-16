import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';

class ExamService {
  static ExamService? _instance;

  factory ExamService() => _instance ??= ExamService._();

  ExamService._();

    Future<Response> getExams(int? subjectID, String? filter) async {

     Map<String, dynamic> queryParameters = {};

      if (subjectID != null) {
        final subjectFilter = <String, int>{"subject" : subjectID};

        queryParameters.addEntries(subjectFilter.entries);
      }

       if (filter != null) {
        final subjectFilter = <String, String>{"filter" : filter};

        queryParameters.addEntries(subjectFilter.entries);
      }


    var response = await Api().dio.get("/api/exam", queryParameters: queryParameters);

    return response;
  }
}