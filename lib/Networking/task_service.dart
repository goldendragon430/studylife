import 'package:dio/dio.dart';
import './api_service.dart';

class TaskService {
  static TaskService? _instance;

  factory TaskService() => _instance ??= TaskService._();

  TaskService._();

  Future<Response> getTasks(int? subjectID, String? filter) async {

     Map<String, dynamic> queryParameters = {};

      if (subjectID != null) {
        final subjectFilter = <String, int>{"subject" : subjectID};

        queryParameters.addEntries(subjectFilter.entries);
      }

       if (filter != null) {
        final subjectFilter = <String, String>{"filter" : filter};

        queryParameters.addEntries(subjectFilter.entries);
      }


    var response = await Api().dio.get("/api/task", queryParameters: queryParameters);

    return response;
  }
}