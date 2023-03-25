import 'dart:io';
import 'package:ctse_app/Model/staff.dart';
import 'package:ctse_app/Util/env.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String? _URI = URI;

Future<bool> addStaff(path, Staff staff) async {
  var response = await http.post(
    Uri.parse('$_URI$path'),
    body: staff.toJson(),
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

Future<bool> updateStaff(path, Staff staff) async {
  var response = await http.put(
    Uri.parse('$_URI$path'),
    body: staff.toJson(),
    headers: {
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    print("called");
    return false;
  }
}

Future<bool> deleteStaff(path, Staff staff) async {
  var response = await http.delete(Uri.parse("$_URI$path?_id=${staff.id}"));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<Staff?> getStaff(path, id) async {
  final uri = Uri.https(_URI!, path, {"_id": id});

  var response = await http.get(uri);
  if (response.statusCode == 200) {
    Staff res = Staff.fromJson(response.body);
    return res;
  } else {
    return null;
  }
}

Future<List<Staff>> getStaffs(path) async {
  var response = await http.get(Uri.parse('$_URI$path'));

  List<Staff> staffs = <Staff>[];
  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    for (var item in data) {
      staffs.add(Staff.fromMap(item));
    }

    return staffs;
  } else {
    return staffs;
  }
}


Future<List<Staff>> getStaffsByName(path, String name) async {
  var response = await http.get(
    Uri.parse('$_URI$path?name=$name'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
  List<Staff> staffs = <Staff>[];
  if (response.statusCode == 200) {
    print("called");
    var data = json.decode(response.body);

    for (var item in data) {
      staffs.add(Staff.fromMap(item));
    }

    return staffs;
  } else {
    return staffs;
  }
}
