import 'package:equatable/equatable.dart';

// class UserModel extends Equatable {
//   final String token;
//   final String username;

//   const UserModel({required this.token, required this.username});

//   @override
//   List<Object> get props => [token, username];

//   @override
//   String toString() => "username: $username, token: $token";

//   static const empty = UserModel(token: "-", username: "-");
// }

enum UserRole { student, admin, teacher }

class UserModel extends Equatable {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final bool isVerified;
  final String verificationCode;
  final String? profileImage;
  final String createdAt;
  final String updatedAt;

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

  const UserModel(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.role,
      required this.isVerified,
      required this.verificationCode,
      this.profileImage,
      required this.createdAt,
      required this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: json['role'],
      isVerified: json['isVerified'],
      verificationCode: json['verificationCode'],
      profileImage: json['profileImageUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map toJson() => {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'role': role,
        'isVerified': isVerified,
        'verificationCode': verificationCode,
        'profileImageUrl': profileImage,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      }..removeWhere(
          (dynamic key, dynamic value) => key == null || value == null);

  @override
  List<Object> get props => [
        id,
        email,
        firstName,
        lastName,
        role,
        isVerified,
        verificationCode,
        createdAt,
        updatedAt
      ];

  @override
  String toString() =>
      "profileImageUrl: $profileImage email: $email, id: $id, firstName: $firstName, lastName: $lastName, role: $role, isVerified: $isVerified, verificationCode: $verificationCode, createdAt: $createdAt, updatedAt: $updatedAt";

  //static const empty = UserModel(id: 0, email: "-");

  static const empty = UserModel(
      id: 0,
      email: "-",
      firstName: '-',
      lastName: '-',
      role: '-',
      isVerified: false,
      verificationCode: '-',
      profileImage: '-',
      createdAt: '-',
      updatedAt: '-');
}
