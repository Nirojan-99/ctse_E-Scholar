// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String email;
  final String password;
  final bool auth;
  final String token;
  User({
    required this.email,
    required this.password,
    required this.auth,
    required this.token,
  });


  User copyWith({
    String? email,
    String? password,
    bool? auth,
    String? token,
  }) {
    return User(
      email: email ?? this.email,
      password: password ?? this.password,
      auth: auth ?? this.auth,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'auth': auth,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      password: map['password'] as String,
      auth: map['auth'] as bool,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(email: $email, password: $password, auth: $auth, token: $token)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password &&
      other.auth == auth &&
      other.token == token;
  }

  @override
  int get hashCode {
    return email.hashCode ^
      password.hashCode ^
      auth.hashCode ^
      token.hashCode;
  }
}
