import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:from_login/Connections/User_json_Model.dart';

import 'package:from_login/login/models/models.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Username.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.userModel,
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final Username email;
  final Password password;
  final String? errorMessage;
  final Welcome? userModel;

  @override
  List<Object> get props => [status, email, password];

  get isValid => null;

  LoginState copyWith(
      {Username? email,
      FormzStatus? status,
      String? errorMessage,
      Welcome? userModel,
      Password? password}) {
    return LoginState(
        email: email ?? this.email,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        userModel: userModel ?? this.userModel,
        password: password ?? this.password);
  }
}
