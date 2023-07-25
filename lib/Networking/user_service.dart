import '../Models/API/access_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';
import '../Models/user.model.dart';
import '../Models/API/practicedSubject.dart';
import '../Models/API/notification_setting.dart';

class UserService {
  static UserService? _instance;
  static String grantType = "password";
  static String clientSecret = "Ri4jK9ujwaHkjrStwOEXQ0P3JTWlUNovQnZ4ffZJ";
  static int clientId = 2;
  final _storage = const FlutterSecureStorage();

  factory UserService() => _instance ??= UserService._();

  UserService._();

  Future<Response> signUp(String email, String password) async {
    var body = jsonEncode({
      "first_name": "Mystudylife",
      "last_name": "User",
      'email': email,
      'password': password,
    });

    var response = await Api().tokenDio.post('/api/auth/sign-up', data: body);

    return response;
  }

  Future<Response> login(String email, String password) async {
    var body = jsonEncode({
      'email': email,
      'password': password,
      // 'client_id': clientId,
      // 'client_secret': clientSecret,
      // 'grant_type': grantType
    });

    var response = await Api().tokenDio.post('/api/auth/login', data: body);
    if (response.statusCode == 200) {
      // var tokenData = JwtDecoder.decode(response.data['token']);
      var tokenString = response.data['token'];
      // print("TOKEN DATA $tokenData");

      // var token = AccessToken.fromJson(tokenData);
      var user = UserModel.fromJson(response.data['user']);
      // var tasksCompleted = response.data['tasksCompleted'];
      // var yourStreak = response.data['streak'];
      // var mostPracticedSubjectTasksCount =
      //     response.data['mostPracticedSubjectTasksThisMonth'];
      // var leastPracticedSubjectTasksCount =
      //     response.data['leastPracticedSubjectTasksThisMonth'];
      // var mostPracticedSubject =
      //     PracticedSubject.fromJson(response.data['mostPracticedSubject']);
      // var leastPracticedSubject =
      //     PracticedSubject.fromJson(response.data['leastPracticedSubject']);

      await _storage.write(key: "access_token", value: tokenString);

      // await _storage.write(key: "tasks_completed", value: tasksCompleted.toString());
      // await _storage.write(key: "your_streak", value: yourStreak.toString());
      // await _storage.write(key: "most_practiced_tasks_count", value: mostPracticedSubjectTasksCount.toString());
      // await _storage.write(key: "least_practiced_tasks_count", value: leastPracticedSubjectTasksCount.toString());
      // await _storage.write(key: "most_practiced_subject", value: jsonEncode(mostPracticedSubject.toJson()));
      // await _storage.write(key: "least_practiced_subject", value: jsonEncode(leastPracticedSubject.toJson()));

      await _storage.write(key: "activeUser", value: jsonEncode(user.toJson()));
    }

    return response;
  }

  Future<Response> loginGoogleUser(
      String email, String userId, String firstName, String lastName) async {
    var body = jsonEncode({
      'email': email,
      'providerUserId': userId,
      "firstName": firstName,
      "lastName": lastName,
    });

    var response = await Api().tokenDio.post('/api/auth/google', data: body);
    if (response.statusCode == 200) {
      // var tokenData = JwtDecoder.decode(response.data['token']);
      var tokenString = response.data['token'];
      // print("TOKEN DATA $tokenData");

      // var token = AccessToken.fromJson(tokenData);
      var user = UserModel.fromJson(response.data['user']);

      await _storage.write(key: "access_token", value: tokenString);
      await _storage.write(key: "activeUser", value: jsonEncode(user.toJson()));
    }

    return response;
  }

  Future<Response> loginFacebookUser(
      String email, String userId, String firstName, String lastName) async {
    var body = jsonEncode({
      'email': email,
      'providerUserId': userId,
      "firstName": firstName,
      "lastName": lastName,
    });

    var response = await Api().tokenDio.post('/api/auth/facebook', data: body);
    if (response.statusCode == 200) {
      // var tokenData = JwtDecoder.decode(response.data['token']);
      var tokenString = response.data['token'];
      // print("TOKEN DATA $tokenData");

      // var token = AccessToken.fromJson(tokenData);
      var user = UserModel.fromJson(response.data['user']);

      await _storage.write(key: "access_token", value: tokenString);
      await _storage.write(key: "activeUser", value: jsonEncode(user.toJson()));
    }

    return response;
  }

  Future<Response> loginMicrosoftUser(
      String email, String userId, String firstName, String lastName) async {
    var body = jsonEncode({
      'email': email,
      'providerUserId': userId,
      "firstName": firstName,
      "lastName": lastName,
    });

    var response = await Api().tokenDio.post('/api/auth/microsoft', data: body);
    if (response.statusCode == 200) {
      // var tokenData = JwtDecoder.decode(response.data['token']);
      var tokenString = response.data['token'];
      // print("TOKEN DATA $tokenData");

      // var token = AccessToken.fromJson(tokenData);
      var user = UserModel.fromJson(response.data['user']);

      await _storage.write(key: "access_token", value: tokenString);
      await _storage.write(key: "activeUser", value: jsonEncode(user.toJson()));
    }

    return response;
  }

  Future<Response> refreshToken() async {
    var tokenString = await _storage.read(key: "access_token");

    // Check for existing token
    if (tokenString != null && tokenString.isNotEmpty) {
      // Decode token from storage
      Map<String, dynamic> userMap = jsonDecode(tokenString);

      var accessToken = AccessToken.fromJson(userMap);

      var body = jsonEncode({
        'refreshToken': accessToken.refreshToken,
        // 'client_id': clientId,
        // 'client_secret': clientSecret,
      });
      var response =
          await Api().tokenDio.post('/api/auth/refresh-token', data: body);

      return response;
    } else {
      var response = await Api().tokenDio.post('/api/auth/refresh-token');

      return response;
    }
  }

  Future<Response> getUser() async {
    var response = await Api().dio.get('/api/user');

    if (response.statusCode == 200) {
      var user = UserModel.fromJson(response.data['user']);

      await _storage.write(key: "activeUser", value: jsonEncode(user.toJson()));
    }

    return response;
  }

  Future<Response> updateUser(String body) async {
    // final map = <String, dynamic>{};
    // map.putIfAbsent('Content-Type', () => "application/json");
    var response = await Api().dio.put('/api/user', data: body);

    // if (response.statusCode == 201 || response.statusCode == 200) {
    //   var user = UserModel.fromJson(response.data['data']);

    //   await _storage.write(
    //       key: "activeUser", value: jsonEncode(user.toJson()));
    // }

    return response;
  }

  Future<Response> updatePersonalization(
      String? country,
      int? settingsDateFormat,
      String? timeFormat,
      String? settingsAcademicInterval,
      String? settingsSession,
      String? settingsDaysOff) async {
    String body;

    body = jsonEncode({
      'country': country,
      'settingsDateFormat': settingsDateFormat,
      'timeFormat': timeFormat,
      'settingsAcademicInterval': settingsAcademicInterval,
      'settingsSession': settingsSession,
      'settingsDaysOff': settingsDaysOff
    }..removeWhere((dynamic key, dynamic value) => value == null));
    var response = await Api().dio.put('/api/user/personalization', data: body);

    return response;
  }

  Future<Response> updateGeneralSettings(
    int? settingsFirstDayOfWeek,
    String? settingsDefaultStartTime,
    int? settingsDefaultDuration,
    String? settingsRotationalSchedule,
    String? settingsDaysToDisplayOnDashboard,
    int? settingsRotationalScheduleNumberOfWeeks,
    String? settingsRotationalScheduleStartWeek,
    int? settingsRotationalScheduleNumberOfDays,
    String? settingsRotationalScheduleStartDay,
    List<String>? days,
  ) async {
    String body;

    String? stringDays = null;
    stringDays = days?.join(",");

    body = jsonEncode({
      'settingsFirstDayOfWeek': settingsFirstDayOfWeek,
      'settingsDefaultStartTime': settingsDefaultStartTime,
      'settingsDefaultDuration': settingsDefaultDuration,
      'settingsRotationalSchedule': settingsRotationalSchedule,
      'settingsDaysToDisplayOnDashboard': settingsDaysToDisplayOnDashboard,
      'settingsRotationalScheduleDays': days,
      'settingsRotationalScheduleNumberOfWeeks':
          settingsRotationalScheduleNumberOfWeeks,
      'settingsRotationalScheduleStartWeek':
          settingsRotationalScheduleStartWeek,
      'settingsRotationalScheduleNumberOfDays':
          settingsRotationalScheduleNumberOfDays,
      'settingsRotationalScheduleStartDay': settingsRotationalScheduleStartDay
    }..removeWhere((dynamic key, dynamic value) => value == null));
    var response =
        await Api().dio.put('/api/user/general-settings', data: body);

    return response;
  }

  Future<Response> updateProfilePicture(String imagePath) async {
    String fileName = imagePath.split('/').last;

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(imagePath, filename: fileName),
    });

    var response =
        await Api().dio.post('/api/user/profile-image', data: formData);

    return response;
  }

  Future<Response> updateUserPassword(String body) async {
    var response = await Api().dio.put('/api/user/password', data: body);

    return response;
  }

  Future<Response> createStripeOnboardingLink() async {
    var response =
        await Api().dio.post('/api/user/create-stripe-onboarding-link');

    return response;
  }

  Future<Response> getHelp(String message) async {
    var body = jsonEncode({'message': message});

    var response = await Api().dio.post('/api/user/get-help', data: body);

    return response;
  }

  Future<Response> subscribeToNotifications(String token) async {
    var body = jsonEncode({'platformType': "ios", "firebaseToken": token});

    var response =
        await Api().dio.post('/api/user/subscribe-firebase', data: body);

    return response;
  }

  Future<Response> getReminders() async {
    var response = await Api().dio.get("/api/reminder/");

    return response;
  }

  Future<Response> updateReminders(
      bool? allSwitch, List<NotificationSetting>? reminders) async {
    String body;

    if (allSwitch != null) {
      List<dynamic> listData = [
        {'type': 'all', 'status': allSwitch == true ? 1 : 0}
      ];

      body = jsonEncode(listData);

      var response = await Api().dio.post('/api/reminder', data: body);

      return response;
    } else {
      body = jsonEncode(reminders?.map((e) => e.toJson()).toList());

      //body = jsonEncode({reminders});

      var response = await Api().dio.post('/api/reminder', data: body);

      return response;
    }
  }

  Future<Response> deleteUser() async {
    var response = await Api().dio.delete('/api/user');

    return response;
  }

  Future<Response> resetPassword(String email) async {
    var body = jsonEncode({'email': email});

    var response =
        await Api().dio.post('/api/auth/forgot-password', data: body);

    return response;
  }
}
