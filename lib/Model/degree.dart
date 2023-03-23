// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Degree {
  final String degree;
  final String codeNumber;
  final String LIC;
  final String facultyId;
  final int duration;
  final String? id;
  Degree({
    required this.degree,
    required this.codeNumber,
    required this.LIC,
    required this.facultyId,
    required this.duration,
    this.id,
  });

  Degree copyWith({
    String? degree,
    String? codeNumber,
    String? LIC,
    String? facultyId,
    int? duration,
    String? id,
  }) {
    return Degree(
      degree: degree ?? this.degree,
      codeNumber: codeNumber ?? this.codeNumber,
      LIC: LIC ?? this.LIC,
      facultyId: facultyId ?? this.facultyId,
      duration: duration ?? this.duration,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'degree': degree,
      'codeNumber': codeNumber,
      'LIC': LIC,
      'facultyId': facultyId,
      'duration': duration,
      '_id': id,
    };
  }

  factory Degree.fromMap(Map<String, dynamic> map) {
    return Degree(
      degree: map['degree'] as String,
      codeNumber: map['codeNumber'] as String,
      LIC: map['LIC'] as String,
      facultyId: map['facultyId'] as String,
      duration: map['duration'] as int,
      id: map['_id'] != null ? map['_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Degree.fromJson(String source) =>
      Degree.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Degree(degree: $degree, codeNumber: $codeNumber, LIC: $LIC, facultyId: $facultyId, duration: $duration, id: $id)';
  }

  @override
  bool operator ==(covariant Degree other) {
    if (identical(this, other)) return true;

    return other.degree == degree &&
        other.codeNumber == codeNumber &&
        other.LIC == LIC &&
        other.facultyId == facultyId &&
        other.duration == duration &&
        other.id == id;
  }

  @override
  int get hashCode {
    return degree.hashCode ^
        codeNumber.hashCode ^
        LIC.hashCode ^
        facultyId.hashCode ^
        duration.hashCode ^
        id.hashCode;
  }
}
