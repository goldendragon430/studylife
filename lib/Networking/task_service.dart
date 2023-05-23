import 'package:dio/dio.dart';
import './api_service.dart';
import '../Models/API/task.dart';
import 'dart:convert';

class TaskService {
  static TaskService? _instance;

  factory TaskService() => _instance ??= TaskService._();

  TaskService._();

  Future<Response> getTasks(int? subjectID, String? filter) async {
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
        await Api().dio.get("/api/task", queryParameters: queryParameters);

    return response;
  }

//   Future<Response> createTask(Task taskItem) async {
//     String body;

//     body = jsonEncode({
//       'subjectId': taskItem.subject?.id ?? 0,
//       'module': taskItem.module,
//       'mode': taskItem.mode,
//       'room': taskItem.room,
//       // 'building': examItem.building,
//       //'teacher': examItem.teacher,
//       //'occurs': examItem.occurs,
//       'startTime': taskItem.startTime,
//       'startDate': taskItem.startDate,
//       'type': taskItem.type,
//       'duration': taskItem.duration,
//       'onlineUrl': taskItem.onlineUrl
//     }..removeWhere((dynamic key, dynamic value) => value == null));

//     var response = await Api().dio.post('/api/task', data: body);
//     print(response);

//     return response;
//   }
 }
