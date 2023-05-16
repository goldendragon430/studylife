import 'package:intl/intl.dart';
import './subject.dart';

class ClassModel {
  int? id;
  int? userId;
  String? module;
  String? mode;
  String? room;
  String? building;
  String? onlineUrl;
  String? teacher;
  String? teachersEmail;
  String? occurs;
  List<String>? days;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  Subject? subject;

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

  ClassModel(
      {this.id,
      this.userId,
      this.module,
      this.mode,
      this.room, 
      this.building,  
      this.onlineUrl,  
      this.teacher,  
      this.teachersEmail,  
      this.occurs,  
      this.days,  
      this.startDate,  
      this.endDate,  
      this.startTime,  
      this.endTime,
      this.subject,
      this.createdAt,
      this.updatedAt});

  factory ClassModel.fromJson(Map<String, dynamic> json) {

    return ClassModel(
        id: json['id'],
        userId: json['userId'],
        module: json['module'],
        mode: json['mode'],
        room: json['room'],
        building: json['building'],
        onlineUrl: json['onlineUrl'],
        teacher: json['teacher'],
        teachersEmail: json['teachersEmail'],
        occurs: json['occurs'],
        subject: json['subject'] != null ? Subject.fromJson(json['subject']) : null,
       // days: json['days'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['module'] = module;
    data['mode'] = mode;
    data['room'] = room;
    data['building'] = building;
    data['onlineUrl'] = onlineUrl;
    data['teacher'] = teacher;
    data['teachersEmail'] = teachersEmail;
    data['occurs'] = occurs;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
     if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    return data;
  }
}
