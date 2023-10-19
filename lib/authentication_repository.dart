import 'dart:async';

import 'package:from_login/Connections/User_json_Model.dart';
import 'package:from_login/login/bloc/authentictionStatus.dart';

import 'login/bloc/authenticationApi.dart';

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  AuthenticationAPI? _authenticationAPI;
  AuthenticationRepository() {
    _authenticationAPI = AuthenticationAPI();
  }

  Welcome? appUser;
  AuthenticationStatus appStatus = AuthenticationStatus.unauthenticated;

  Welcome? get user {
    return appUser;
  }

  Stream<AuthenticationStatus> get status async* {
    // await Future<void>.delayed(const Duration(seconds: 1));
    yield appStatus;
    yield* _controller.stream;
  }

  Future<Welcome> logInOrRegister({
    required dynamic body,
  }) async {
    try {
      var data = await _authenticationAPI?.loginWithEmailPassowrd(body: body);
      appUser = Welcome.fromJson(data);

      return appUser!;
    } catch (e) {
      rethrow;
    }
  }

  void dispose() => _controller.close();
}
