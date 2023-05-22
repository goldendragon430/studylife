import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';
import '../Models/API/subject.dart';

class SubjectService {
  static SubjectService? _instance;

  factory SubjectService() => _instance ??= SubjectService._();

  SubjectService._();

  Future<Response> getSubjects() async {
    var response = await Api().dio.get("/api/subject");

    return response;
  }

  Future<Response> createSubject(Subject subjectItem) async {
    String fileName = subjectItem.imageUrl!.split('/').last;

    FormData formData = FormData.fromMap({
      "subject": subjectItem.subjectName,
      "color" : subjectItem.colorHex,
      "image": await MultipartFile.fromFile(subjectItem.imageUrl!,
          filename: fileName),
    });

    var response = await Api().dio.post('/api/subject', data: formData);

    return response;
  }
}
