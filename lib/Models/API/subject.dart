import 'package:intl/intl.dart';

class Subject {
  int? id;
  int? userId;
  String? subjectName;
  String? colorHex;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  // Calculated

  String getFormattedDate() {
    DateTime? createdAtDate = DateTime.tryParse(createdAt ?? "");

    if (createdAtDate != null) {
      String formattedDate =
          DateFormat('MM/dd/yyyy HH:mm:ss').format(createdAtDate);
      return formattedDate;
    } else {
      return "";
    }
  }

  Subject(
      {this.id,
      this.userId,
      this.subjectName,
      this.colorHex,
      this.imageUrl,  
      this.createdAt,
      this.updatedAt});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
        id: json['id'],
        userId: json['userId'],
        subjectName: json['subject'],
        colorHex: json['color'],
        imageUrl: json['imageUrl'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
