import 'dart:io';
import 'package:ctse_app/Model/student.dart';
import 'package:ctse_app/Util/env.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String? _URI = URI;

Future<bool> addStudent(path, Student student) async {
  try {
    var response = await http.post(
      Uri.parse('$_URI$path'),
      body: student.toJson(),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<bool> updateStudent(path, Student student) async {
  var response = await http.put(
    Uri.parse('$_URI$path'),
    body: student.toJson(),
    headers: {
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> deleteStudent(path, Student student) async {
  var response = await http.delete(Uri.parse("$_URI$path?_id=${student.id}"));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<Student?> getStudent(path, id) async {
  final uri = Uri.https(_URI!, path, {"_id": id});

  var response = await http.get(uri);
  if (response.statusCode == 200) {
    Student res = Student.fromJson(response.body);
    return res;
  } else {
    return null;
  }
}

Future<List<Student>> getStudents(path) async {
  var response = await http.get(Uri.parse('$_URI$path'));

  List<Student> students = <Student>[];
  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    for (var item in data) {
      students.add(Student.fromMap(item));
    }

    return students;
  } else {
    return students;
  }
}

Future<List<Student>> getStudentsByName(path, String name) async {
  var response = await http.get(
    Uri.parse('$_URI$path?name=$name'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
  List<Student> students = <Student>[];
  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    for (var item in data) {
      students.add(Student.fromMap(item));
    }

    return students;
  } else {
    return students;
  }
}
