// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Student {
  final String firstName;
  final String lastName;
  final String email;
  final int contactNumber;
  final String idNumber;
  final String facultyId;
  final String degreeId;
  final String role;
  final String? id;
  final int academicYear;
  Student({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.idNumber,
    required this.facultyId,
    required this.degreeId,
    required this.role,
    this.id,
    required this.academicYear,
  });

  Student copyWith({
    String? firstName,
    String? lastName,
    String? email,
    int? contactNumber,
    String? idNumber,
    String? facultyId,
    String? degreeId,
    String? role,
    String? id,
    int? academicYear,
  }) {
    return Student(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      idNumber: idNumber ?? this.idNumber,
      facultyId: facultyId ?? this.facultyId,
      degreeId: degreeId ?? this.degreeId,
      role: role ?? this.role,
      id: id ?? this.id,
      academicYear: academicYear ?? this.academicYear,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'contactNumber': contactNumber,
      'idNumber': idNumber,
      'facultyId': facultyId,
      'degreeId': degreeId,
      'role': role,
      '_id': id,
      'academicYear': academicYear,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      contactNumber: map['contactNumber'] as int,
      idNumber: map['idNumber'] as String,
      facultyId: map['facultyId'] as String,
      degreeId: map['degreeId'] as String,
      role: map['role'] as String,
      id: map['_id'] != null ? map['_id'] as String : null,
      academicYear: map['academicYear'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) => Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(firstName: $firstName, lastName: $lastName, email: $email, contactNumber: $contactNumber, idNumber: $idNumber, facultyId: $facultyId, degreeId: $degreeId, role: $role, id: $id, academicYear: $academicYear)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.email == email &&
      other.contactNumber == contactNumber &&
      other.idNumber == idNumber &&
      other.facultyId == facultyId &&
      other.degreeId == degreeId &&
      other.role == role &&
      other.id == id &&
      other.academicYear == academicYear;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      contactNumber.hashCode ^
      idNumber.hashCode ^
      facultyId.hashCode ^
      degreeId.hashCode ^
      role.hashCode ^
      id.hashCode ^
      academicYear.hashCode;
  }
}


