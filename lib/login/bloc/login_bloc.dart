import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';

import '../../authentication_repository.dart';
import '../models/password.dart';
import '../models/username.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Username.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password]),
    ));
  }

  Future<void> logInWithCredentials(String Email, String Password) async {
    // if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      final body = {
        'user_name': Email,
        'user_password': Password,
      };
      var res = await _authenticationRepository.logInOrRegister(body: body);
      if (res.status == true) {
        emit(state.copyWith(
            userModel: res, status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(
            errorMessage: res.message, status: FormzStatus.submissionFailure));
      }
      // ignore: nullable_type_in_catch_clause
    } on logInOrRegisterFailure catch (e) {
      emit(state.copyWith(
        errorMessage: e.message,
        status: FormzStatus.submissionFailure,
      ));
    } on DioError catch (e) {
      emit(state.copyWith(
          errorMessage: e.response?.data == null
              ? e.response?.statusMessage
              : e.response?.data['message'].toString(),
          status: FormzStatus.submissionFailure));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

class logInOrRegisterFailure implements Exception {
  const logInOrRegisterFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory logInOrRegisterFailure.fromCode(String code) {
    switch (code) {
      case 'wrong-credential':
        return const logInOrRegisterFailure(
          'Incorrect password/email, please try again.',
        );
      default:
        return logInOrRegisterFailure(code);
    }
  }

  final String message;
}
