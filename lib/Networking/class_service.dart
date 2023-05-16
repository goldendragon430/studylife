import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';

class ClassService {
  static ClassService? _instance;

  factory ClassService() => _instance ??= ClassService._();

  ClassService._();

    Future<Response> getClasses(int? subjectID) async {

    var response = await Api().dio.get("/api/class");

    return response;
  }
}