import '../../Connections/dio_manager.dart';

class AuthenticationAPI {
  AuthenticationAPI();
  final http = HTTP.instance;

  Future<dynamic> loginWithEmailPassowrd({required body}) async {
    try {
      return await http.iPost('/auth/login', data: body);
    } catch (e) {
      rethrow;
    }
  }
}
