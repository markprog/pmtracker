import 'dart:async';
import 'dart:convert';

import 'package:user_repository/src/models/models.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  User? _user;
  Future<User?> getUser(String accessToken) async {
    final response = await http.get(Uri.parse("https://tracker.svmatrix.com/api/get-user-data"), headers: {
      "Authorization": "Bearer $accessToken"
    });
    _user = User.fromJson(jsonDecode(response.body));
    return _user ?? User.empty;
  }
}
