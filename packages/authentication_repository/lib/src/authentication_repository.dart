import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_repository/user_repository.dart';
import 'package:shared_preferences_repository/src/storage.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final SharedPreferencesHelper storage;

  AuthenticationRepository({required this.storage});

  Future<User?> getSavedUser() async {
    final userJson = await storage.user;
    final decodeJson = jsonDecode(userJson);
    return User.fromJson(decodeJson);
  }

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield AuthenticationStatus.unknown;
    yield* _controller.stream;
  }

    Future<http.Response> logIn({
      required String email,
      required String password,
    }) async {
      final request = await http.post(
          Uri.parse("https://tracker.svmatrix.com/api/auth/login"), body: {
        "email": email,
        "password": password
      });
      final response = jsonDecode(request.body);
      print(request.statusCode);
      if(request.statusCode == 200 && response['data']['result'] != false) {
        print("$response");
        _controller.add(AuthenticationStatus.authenticated);
      }
      return request;
    }

    Future<void> logout() async {
    final accessToken = await storage.accessToken;
    final response = await http.get(Uri.parse("https://tracker.svmatrix.com/api/logout"), headers: {
      "Authorization": "Bearer $accessToken"
    });
      _controller.add(AuthenticationStatus.unauthenticated);
    }

    void dispose() => _controller.close();
}
