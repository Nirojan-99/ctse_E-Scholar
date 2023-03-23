import 'dart:io';
import 'package:ctse_app/Model/degree.dart';
import 'package:ctse_app/Util/env.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String? _URI = URI;

Future<bool> addDegree(path, Degree degree) async {
  try {
    var response = await http.post(
      Uri.parse('$_URI$path'),
      body: degree.toJson(),
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

Future<bool> updateDegree(path, Degree degree) async {
  var response = await http.put(
    Uri.parse('$_URI$path'),
    body: degree.toJson(),
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

Future<bool?> deleteDegree(path, Degree degree) async {
  var response = await http.delete(Uri.parse("$_URI$path?_id=${degree.id}"));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<Degree?> getDegree(path, id) async {
  final uri = Uri.https(_URI!, path, {"_id": id});

  var response = await http.get(uri);
  if (response.statusCode == 200) {
    Degree res = Degree.fromJson(response.body);
    return res;
  } else {
    return null;
  }
}

Future<List<Degree>> getDegrees(path) async {
  var response = await http.get(Uri.parse('$_URI$path'));

  List<Degree> degrees = <Degree>[];
  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    for (var item in data) {
      degrees.add(Degree.fromMap(item));
    }

    return degrees;
  } else {
    return degrees;
  }
}

Future<List<Degree>> getDegreesByFaculty(path,faculty) async {
  print(faculty);
  var response = await http.get(Uri.parse('$_URI$path?faculty=$faculty'));

  List<Degree> degrees = <Degree>[];
  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    for (var item in data) {
      degrees.add(Degree.fromMap(item));
    }

    return degrees;
  } else {
    return degrees;
  }
}

Future<List<Degree>> getDegreeByName(path, String name) async {
  var response = await http.get(
    Uri.parse('$_URI$path?name=$name'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
  List<Degree> degrees = <Degree>[];
  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    for (var item in data) {
      degrees.add(Degree.fromMap(item));
    }

    return degrees;
  } else {
    return degrees;
  }
}
