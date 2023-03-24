// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Faculty {
  final String facultyName;
  final String codeNumber;
  final String? HOD;
  final String? id;
  Faculty({
    required this.facultyName,
    required this.codeNumber,
    this.HOD,
    this.id,
  });

  Faculty copyWith({
    String? facultyName,
    String? codeNumber,
    String? HOD,
    String? id,
  }) {
    return Faculty(
      facultyName: facultyName ?? this.facultyName,
      codeNumber: codeNumber ?? this.codeNumber,
      HOD: HOD ?? this.HOD,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'facultyName': facultyName,
      'codeNumber': codeNumber,
      'HOD': HOD,
      '_id': id,
    };
  }

  factory Faculty.fromMap(Map<String, dynamic> map) {
    return Faculty(
      facultyName: map['facultyName'] as String,
      codeNumber: map['codeNumber'] as String,
      HOD: map['HOD'] != null ? map['HOD'] as String : null,
      id: map['_id'] != null ? map['_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Faculty.fromJson(String source) =>
      Faculty.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Faculty(facultyName: $facultyName, codeNumber: $codeNumber, HOD: $HOD, id: $id)';
  }

  @override
  bool operator ==(covariant Faculty other) {
    if (identical(this, other)) return true;

    return other.facultyName == facultyName &&
        other.codeNumber == codeNumber &&
        other.HOD == HOD &&
        other.id == id;
  }

  @override
  int get hashCode {
    return facultyName.hashCode ^
        codeNumber.hashCode ^
        HOD.hashCode ^
        id.hashCode;
  }
}
