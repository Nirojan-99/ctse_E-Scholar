// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Staff {
  final String firstName;
  final String lastName;
  final String email;
  final int contactNumber;
  final String division;
  final String? faculty;
  final String? role;
  final String? sector;
  final String? id;
  Staff({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.division,
    this.faculty,
    this.role,
    this.sector,
    this.id,
  });

  Staff copyWith({
    String? firstName,
    String? lastName,
    String? email,
    int? contactNumber,
    String? division,
    String? faculty,
    String? role,
    String? sector,
    String? id,
  }) {
    return Staff(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      division: division ?? this.division,
      faculty: faculty ?? this.faculty,
      role: role ?? this.role,
      sector: sector ?? this.sector,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'contactNumber': contactNumber,
      'division': division,
      'faculty': faculty,
      'role': role,
      'sector': sector,
      '_id': id,
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      contactNumber: map['contactNumber'] as int,
      division: map['division'] as String,
      faculty: map['faculty'] != null ? map['faculty'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      sector: map['sector'] != null ? map['sector'] as String : null,
      id: map['_id'] != null ? map['_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) => Staff.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Staff(firstName: $firstName, lastName: $lastName, email: $email, contactNumber: $contactNumber, division: $division, faculty: $faculty, role: $role, sector: $sector, id: $id)';
  }

  @override
  bool operator ==(covariant Staff other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.email == email &&
      other.contactNumber == contactNumber &&
      other.division == division &&
      other.faculty == faculty &&
      other.role == role &&
      other.sector == sector &&
      other.id == id;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      contactNumber.hashCode ^
      division.hashCode ^
      faculty.hashCode ^
      role.hashCode ^
      sector.hashCode ^
      id.hashCode;
  }
}

