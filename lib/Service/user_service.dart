import 'package:e_scholar/Model/user.dart';
import 'package:e_scholar/Util/env.dart';
import 'package:http/http.dart' as http;

final String? _URI = URI;

Future<User?> loginService(path, email, password) async {
  var response = await http.post(Uri.parse('$_URI$path'),
      body: {"email": email, "password": password});
  if (response.statusCode == 200) {
    User user = User.fromJson(response.body);
    return user;
  } else {
    return null;
  }
}

Future<User?> checkMail(path, email) async {
  var response = await http.post(
      Uri.parse(
        "$_URI$path",
      ),
      body: {"email": email});
  if (response.statusCode == 200) {
    print(response.body);
    User user = User.fromJson(response.body);
    return user;
  } else {
    return null;
  }
}

Future<User?> checkOTP(path, email, OTP) async {
  var response = await http.post(
      Uri.parse(
        "$_URI$path",
      ),
      body: {"email": email, "otp": OTP});
  if (response.statusCode == 200) {
    User user = User.fromJson(response.body);
    return user;
  } else {
    return null;
  }
}

Future<User?> resetPassword(path, email, password) async {
  var response = await http.post(
      Uri.parse(
        "$_URI$path",
      ),
      body: {"email": email, "password": password});
  if (response.statusCode == 200) {
    User user = User.fromJson(response.body);
    return user;
  } else {
    return null;
  }
}
