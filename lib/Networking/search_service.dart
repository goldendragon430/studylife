import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';
import '../Models/API/classmodel.dart';

class SearchService {
  static SearchService? _instance;

  factory SearchService() => _instance ??= SearchService._();

  SearchService._();

  Future<Response> getSearchResults(String searchText) async {
    var response = await Api().dio.get("/api/user/search?query=$searchText");

    return response;
  }
}
