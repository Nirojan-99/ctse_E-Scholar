import 'dart:io';
import 'package:e_scholar/Model/module.dart';
import 'package:e_scholar/Util/env.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String? _URI = URI;

Future<bool> addModule(path, Module module) async {
  try {
    var response = await http.post(
      Uri.parse('$_URI$path'),
      body: module.toJson(),
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

Future<bool> updateModule(path, Module module) async {
  var response = await http.put(
    Uri.parse('$_URI$path'),
    body: module.toJson(),
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

Future<bool> deleteModule(path, Module module) async {
  var response = await http.delete(Uri.parse("$_URI$path?_id=${module.id}"));
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<Module?> getModule(path, id) async {
  final uri = Uri.https(_URI!, path, {"_id": id});

  var response = await http.get(uri);
  if (response.statusCode == 200) {
    Module res = Module.fromJson(response.body);
    return res;
  } else {
    return null;
  }
}

Future<List<Module>> getModules(path) async {
  var response = await http.get(Uri.parse('$_URI$path'));

  List<Module> modules = <Module>[];
  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    for (var item in data) {
      modules.add(Module.fromMap(item));
    }

    return modules;
  } else {
    return modules;
  }
}

Future<List<Module>> getModuleByName(path, String name) async {
  var response = await http.get(
    Uri.parse('$_URI$path?name=$name'),
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
  );
  List<Module> modules = <Module>[];
  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    for (var item in data) {
      modules.add(Module.fromMap(item));
    }

    return modules;
  } else {
    return modules;
  }
}
