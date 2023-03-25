// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Module {
  final String moduleName;
  final String moduleCode;
  final String LIC;
  final String enrolmentKey;
  final int duration;
  final String courseId;
  final String? id;
  Module({
    required this.moduleName,
    required this.moduleCode,
    required this.LIC,
    required this.enrolmentKey,
    required this.duration,
    required this.courseId,
    this.id,
  });

  Module copyWith({
    String? moduleName,
    String? moduleCode,
    String? LIC,
    String? enrolmentKey,
    int? duration,
    String? courseId,
    String? id,
  }) {
    return Module(
      moduleName: moduleName ?? this.moduleName,
      moduleCode: moduleCode ?? this.moduleCode,
      LIC: LIC ?? this.LIC,
      enrolmentKey: enrolmentKey ?? this.enrolmentKey,
      duration: duration ?? this.duration,
      courseId: courseId ?? this.courseId,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'moduleName': moduleName,
      'moduleCode': moduleCode,
      'LIC': LIC,
      'enrolmentKey': enrolmentKey,
      'duration': duration,
      'courseId': courseId,
      '_id': id,
    };
  }

  // factory Module.fromMap(Map<String, dynamic> map) {
  //   return Module(
  //     moduleName: map['moduleName'] as String,
  //     moduleCode: map['moduleCode'] as String,
  //     LIC: map['LIC'] as String,
  //     enrolmentKey: map['enrolmentKey'] as String,
  //     duration: map['duration'] as int,
  //     courseId: map['courseId'] as String,
  //     id: map['_id'] != null ? map['_id'] as String : null,
  //   );
  // }

  String toJson() => json.encode(toMap());

  factory Module.fromJson(String source) =>
      Module.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Module(moduleName: $moduleName, moduleCode: $moduleCode, LIC: $LIC, enrolmentKey: $enrolmentKey, duration: $duration, courseId: $courseId, id: $id)';
  }

  @override
  bool operator ==(covariant Module other) {
    if (identical(this, other)) return true;

    return other.moduleName == moduleName &&
        other.moduleCode == moduleCode &&
        other.LIC == LIC &&
        other.enrolmentKey == enrolmentKey &&
        other.duration == duration &&
        other.courseId == courseId &&
        other.id == id;
  }

  @override
  int get hashCode {
    return moduleName.hashCode ^
        moduleCode.hashCode ^
        LIC.hashCode ^
        enrolmentKey.hashCode ^
        duration.hashCode ^
        courseId.hashCode ^
        id.hashCode;
  }
}
