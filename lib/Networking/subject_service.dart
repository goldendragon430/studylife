import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';

class SubjectService {
  static SubjectService? _instance;

  factory SubjectService() => _instance ??= SubjectService._();

  SubjectService._();

    Future<Response> getSubjects() async {

    var response = await Api().dio.get("/api/subject");

    return response;
  }
}