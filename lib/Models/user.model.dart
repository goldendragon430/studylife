import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

enum UserRole { student, admin, teacher }

class UserModel extends Equatable {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? role;
  final bool? isVerified;
  final String? profileImageUrl;
  final String? profileImage;
  final String? createdAt;
  final String? updatedAt;
  final String? provider;
  final String? deletedAt;
  final String? status;
  final String? lastActiveAt;
  final String? lastLoginAt;
  final int? settingsDateFormat;
  final bool? settingsIs24Hour;
  final String? settingsAcademicInterval;
  final String? settingsSession;
  final String? settingsDaysOff;
  final String? country;
  final int? settingsFirstDayOfWeek;
  final String? settingsDefaultStartTime;
  final int? settingsDefaultDuration;
  final bool? settingsIsRotationScheduleLettered;
  final String? settingsRotationalSchedule;
  final int? settingsDaysToDisplayOnDashboard;
  final int? settingsRotationalScheduleNumberOfWeeks;
  final String? settingsRotationalScheduleStartWeek;
  final int? settingsRotationalScheduleNumberOfDays;
  final String? settingsRotationalScheduleStartDay;
  final List<String>? settingsRotationalScheduleDays;
  final String? timeFormat;

  // Calculated
  UserRole calculatedVerifiedStatus() {
    if (role == "student") {
      return UserRole.student;
    }
    if (role == "admin") {
      return UserRole.admin;
    }
    if (role == "teacher") {
      return UserRole.teacher;
    }

    return UserRole.student;
  }

  DateFormat prefferedDateFormat() {
    switch (settingsDateFormat) {
      case 0:
      return DateFormat('MMM dd, yyyy');
      case 1:
      return DateFormat('dd MMM, yyyy');
      case 2:
      return DateFormat('yyyy, MMM dd');
      default:  return DateFormat('MMM dd, yyyy');
    }
  }

  const UserModel( 
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.role,
      required this.isVerified,
      // required this.verificationCode,
      this.profileImage,
      this.profileImageUrl,
      this.provider,
      this.deletedAt,
      this.status,
      this.lastActiveAt,
      this.lastLoginAt,
      required this.createdAt,
      required this.updatedAt,
      this.settingsDateFormat,
      this.settingsIs24Hour,
      this.settingsAcademicInterval,
      this.settingsSession,
      this.settingsDaysOff,
      this.country,
      this.settingsFirstDayOfWeek,
      this.settingsDefaultStartTime,
      this.settingsDefaultDuration,
      this.settingsIsRotationScheduleLettered,
      this.settingsRotationalSchedule,
      this.settingsDaysToDisplayOnDashboard,
      this.settingsRotationalScheduleNumberOfWeeks,
      this.settingsRotationalScheduleStartWeek,
      this.settingsRotationalScheduleNumberOfDays,
      this.settingsRotationalScheduleStartDay,
      this.settingsRotationalScheduleDays,
      this.timeFormat});

  factory UserModel.fromJson(Map<String, dynamic> json) {
      List<String> dayStrings = [];

    if (json['settingsRotationalScheduleDays'] != null) {
      List<dynamic> rawDays = json['settingsRotationalScheduleDays'];
      dayStrings = rawDays.map(
        (item) {
          return item as String;
        },
      ).toList();
    }

    return UserModel(
      id: json['id'],
      profileImageUrl: json['profileImageUrl'],
      provider: json['provider'],
      deletedAt: json['deletedAt'],
      status: json['status'],
      lastActiveAt: json['lastActiveAt'],
      lastLoginAt: json['lastLoginAt'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: json['role'],
      isVerified: json['isVerified'],
      profileImage: json['profileImage'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      settingsDateFormat: json['settingsDateFormat'],
      settingsIs24Hour: json['settingsIs24Hour'],
      settingsAcademicInterval: json['settingsAcademicInterval'],
      settingsSession: json['settingsSession'],
      settingsDaysOff: json['settingsDaysOff'],
      country: json['country'],
      settingsFirstDayOfWeek: json['settingsFirstDayOfWeek'],
      settingsDefaultStartTime: json['settingsDefaultStartTime'],
      settingsDefaultDuration: json['settingsDefaultDuration'],
      settingsIsRotationScheduleLettered: json['settingsIsRotationScheduleLettered'],
      settingsRotationalSchedule: json['settingsRotationalSchedule'],
      settingsDaysToDisplayOnDashboard: json['settingsDaysToDisplayOnDashboard'],
      settingsRotationalScheduleNumberOfWeeks: json['settingsRotationalScheduleNumberOfWeeks'],
      settingsRotationalScheduleStartWeek: json['settingsRotationalScheduleStartWeek'],
      settingsRotationalScheduleNumberOfDays: json['settingsRotationalScheduleNumberOfDays'],
      settingsRotationalScheduleStartDay: json['settingsRotationalScheduleStartDay'],
      settingsRotationalScheduleDays: dayStrings,
      timeFormat: json['timeFormat']
    );
  }

  Map toJson() => {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
        'isVerified': isVerified,
        'provider': provider,
        'deletedAt': deletedAt,
        'status': status,
        'lastActiveAt': lastActiveAt,
        'lastLoginAt': lastLoginAt,
        'profileImageUrl': profileImageUrl,
        'profileImage': profileImage,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'settingsDateFormat': settingsDateFormat,
        'settingsIs24Hour': settingsIs24Hour,
        'settingsAcademicInterval': settingsAcademicInterval,
        'settingsSession': settingsSession,
        'settingsDaysOff': settingsDaysOff,
        'country': country,
        'settingsFirstDayOfWeek': settingsFirstDayOfWeek,
        'settingsDefaultStartTime': settingsDefaultStartTime,
        'settingsDefaultDuration': settingsDefaultDuration,
        'settingsIsRotationScheduleLettered': settingsIsRotationScheduleLettered,
        'settingsRotationalSchedule': settingsRotationalSchedule,
        'settingsDaysToDisplayOnDashboard': settingsDaysToDisplayOnDashboard,
        'settingsRotationalScheduleNumberOfWeeks': settingsRotationalScheduleNumberOfWeeks,
        'settingsRotationalScheduleStartWeek': settingsRotationalScheduleStartWeek,
        'settingsRotationalScheduleNumberOfDays': settingsRotationalScheduleNumberOfDays,
        'settingsRotationalScheduleStartDay': settingsRotationalScheduleStartDay,
        'settingsRotationalScheduleDays': settingsRotationalScheduleDays,
        'timeFormat': timeFormat
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        role,
        isVerified,
      //  verificationCode,
        createdAt,
        updatedAt
      ];

  @override
  String toString() =>
      "profileImageUrl: $profileImage email: $email, id: $id, firstName: $firstName, lastName: $lastName, role: $role, isVerified: $isVerified, createdAt: $createdAt, updatedAt: $updatedAt";

  //static const empty = UserModel(id: 0, email: "-");

  static const empty = UserModel(
      id: 0,
      email: "-",
      firstName: '-',
      lastName: '-',
      role: '-',
      isVerified: false,
      // verificationCode: '-',
      profileImage: '-',
      createdAt: '-',
      updatedAt: '-');

 // @override
  // TODO: implement props
 // List<Object?> get props => throw UnimplementedError();
}
