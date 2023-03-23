import 'dart:io';
import 'package:ctse_app/Model/faculty.dart';
import 'package:ctse_app/Util/env.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String? _URI = URI;

Future<bool> addFaculty(path, Faculty faculty) async {
  try {
    var response = await http.post(
      Uri.parse('$_URI$path'),
      body: faculty.toJson(),
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

Future<bool> updateFaculty(path, Faculty faculty) async {
  var response = await http.put(
    Uri.parse('$_URI$path'),
    body: faculty.toJson(),
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

Future<bool> deleteFaculty(path, Faculty faculty) async {
  var response = await http.delete(Uri.parse('$_URI$path?_id=${faculty.id}'));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<Faculty?> getFaculty(path, id) async {
  final uri = Uri.https(_URI!, path, {"_id": id});

  var response = await http.get(uri);
  if (response.statusCode == 200) {
    Faculty res = Faculty.fromJson(response.body);
    return res;
  } else {
    return null;
  }
}
