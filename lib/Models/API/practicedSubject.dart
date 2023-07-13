import './subject.dart';

class PracticedSubject {
  String? subjectId;
  String? count;
  Subject? subject;

  PracticedSubject({this.subjectId, this.count, this.subject});

  factory PracticedSubject.fromJson(Map<String, dynamic> json) {
    return PracticedSubject(
      subjectId: json['subjectId'],
      count: json['count'],
      subject:
          json['subject'] != null ? Subject.fromJson(json['subject']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subjectId'] = subjectId;
    data['count'] = count;
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    return data;
  }
}
