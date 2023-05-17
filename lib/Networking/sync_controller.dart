import '../Models/Services/storage_item.dart';
import '../Models/Services/storage_service.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

// Services
import '../Networking/subject_service.dart';
import '../Networking/class_service.dart';
import '../Networking/exam_service.dart';
import '../Networking/task_service.dart';
import '../Networking/home_service.dart';

// Models
import '../Models/API/subject.dart';
import '../Models/API/classmodel.dart';
import '../Models/API/result.dart';
import '../Models/API/exam.dart';
import '../Models/API/task.dart';

class SyncController {
  final StorageService _storageService = StorageService();
  static List<Subject> subjects = [];
  static List<ClassModel> classes = [];
  static List<Exam> exams = [];
  static List<Task> tasks = [];
 

  Future<dynamic> syncAll() async {
    // ErrorState error = ErrorState("Opps");
    Result finalResult = Result.loading("Loading");
    await Future.wait(
        [_getSubjects(), _getHomeData()]).then((v) {

      finalResult = Result.success("Success");

      return finalResult;
    }, onError: (err) {
      // error = err;
      finalResult = Result.error(err.toString());
      print("Error ${err.msg}");
      return Result.error(err.toString());
    }).catchError((e) {
      print("Error2 ${e}");

      //error = e;
      finalResult = Result.error(e.toString());
      return Result.error(e.toString());
    });
    return finalResult;
  }

  Future _getHomeData() async {
    try {
      var homeDataResponse = await HomeService().getHomeData();

      final classList = (homeDataResponse.data['classes']) as List;
      classes = classList.map((i) => ClassModel.fromJson(i)).toList();
      _storageService
          .writeSecureData(StorageItem("user_classes", jsonEncode(classes)));

      final examList = (homeDataResponse.data['exams']) as List;
      exams = examList.map((i) => Exam.fromJson(i)).toList();
      _storageService
          .writeSecureData(StorageItem("user_exams", jsonEncode(exams)));

      final taskList = (homeDataResponse.data['tasks']) as List;
      tasks = taskList.map((i) => Task.fromJson(i)).toList();
      _storageService
          .writeSecureData(StorageItem("user_tasks", jsonEncode(exams)));

      // for (var subject in subjects) {
      //   print("SUBJECtS ${subject.subjectName}");
      // }
    } catch (error) {
      if (error is DioError) {
        throw Result.error(error.response?.data['message']);
      } else {
        throw Result.error(error.toString());
      }
    }
  }

  Future _getSubjects() async {
    try {
      var subjectsResponse = await SubjectService().getSubjects();

      final subjectsList = (subjectsResponse.data['subjects']) as List;
      subjects = subjectsList.map((i) => Subject.fromJson(i)).toList();
      _storageService
          .writeSecureData(StorageItem("user_subjects", jsonEncode(subjects)));

      // for (var subject in subjects) {
      //   print("SUBJECtS ${subject.subjectName}");
      // }
    } catch (error) {
      if (error is DioError) {
        throw Result.error(error.response?.data['message']);
      } else {
        throw Result.error(error.toString());
      }
    }
  }

  Future _getClasses() async {
    try {
      var classesResponse = await ClassService().getClasses(null);

      final classList = (classesResponse.data['classes']) as List;
      classes = classList.map((i) => ClassModel.fromJson(i)).toList();
      _storageService
          .writeSecureData(StorageItem("user_classes", jsonEncode(classes)));

      // for (var classItem in classes) {
      //   print("SUBJECtS ${classItem.module}");
      // }
    } catch (error) {
      if (error is DioError) {
        throw Result.error(error.response?.data['message']);
      } else {
        throw Result.error(error.toString());
      }
    }
  }

  Future _getExams() async {
    try {
      var classesResponse = await ExamService().getExams(null, null);

      final examList = (classesResponse.data['exams']) as List;
      exams = examList.map((i) => Exam.fromJson(i)).toList();
      _storageService
          .writeSecureData(StorageItem("user_exams", jsonEncode(exams)));

      for (var examItem in exams) {
        print("EXAMS ${examItem.subject?.subjectName}");
      }
    } catch (error) {
      if (error is DioError) {
        throw Result.error(error.response?.data['message']);
      } else {
        throw Result.error(error.toString());
      }
    }
  }

  Future _getTasksDue() async {
    try {
      var classesResponse = await TaskService().getTasks(null, null);

      final taskList = (classesResponse.data['tasks']) as List;
      tasks = taskList.map((i) => Task.fromJson(i)).toList();
      _storageService
          .writeSecureData(StorageItem("user_tasks", jsonEncode(exams)));

      for (var taskItem in tasks) {
        print("TASKS ${taskItem.subject?.subjectName}");
      }
    } catch (error) {
      if (error is DioError) {
        throw Result.error(error.response?.data['message']);
      } else {
        throw Result.error(error.toString());
      }
    }
  }
}
