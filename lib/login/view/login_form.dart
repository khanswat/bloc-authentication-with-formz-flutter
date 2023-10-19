import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:flutter/material.dart';

import 'package:from_login/main.dart';

import '../../Home.dart';
import '../../authentication_repository.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: Container(
      //   margin: EdgeInsets.only(bottom: 20),
      //   child: TextButton(
      //     onPressed: () {
      //       NavigationService.instance.navigateTo(ChangeRoute);
      //     },
      //     child: Text(
      //       'Reset Password',
      //       textAlign: TextAlign.center,
      //       style: TextStyle(
      //           fontSize: 14,
      //           color: tempColor.blueColor,
      //           fontWeight: FontWeight.w600),
      //     ),
      //   ),
      // ),
      body: BlocProvider(
        create: (_) => LoginCubit(
          context.read<AuthenticationRepository>(),
        ),
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(
                    state.errorMessage ?? 'Login Error',
                  ),
                ));
            }
            if (state.status.isSubmissionSuccess) {
              final cubit = context.read<LoginCubit>();
              // state.email.value.toLowerCase() == '1qr'
              //     ?
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Home(),
              ));
              // NavigationService.instance.pushAndReplac(main());
              // : NavigationService.instance
              //     .pushAndReplac(OtpVerificationRoute);

              // _sharedPrefs
              //     .setToken(cubit.state.userModel?.data.accessToken ?? '');
              // NavigationService.instance.navigatorKey.currentContext!
              //     .read<Welcome>()
              //     .updateName(context.read<LoginCubit>().state.userModel?.data);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Welcome To!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.amber,
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        'Sign in to continue.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.amber,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Image.asset(
                      //   'logo_1'.png,
                      //   height: 120,
                      // ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      //todo Email Field
                      BlocBuilder<LoginCubit, LoginState>(
                        buildWhen: (previous, current) =>
                            previous.email != current.email,
                        key: const Key('loginForm_numberInput_textField'),
                        builder: (context, state) {
                          return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  decoration: InputDecoration(
                                      icon: GestureDetector(
                                          onTap: () => emailController.clear(),
                                          child: const Icon(Icons.clear)),
                                      hintText: 'Email / Username'),
                                  controller: emailController,

                                  // obscureText: false,
                                  //   validator: (value) {

                                  validator: (value) {
                                    state.email.invalid
                                        ? 'Incorrect Email'
                                        : null;
                                    onChanged:
                                    (email) => context
                                        .read<LoginCubit>()
                                        .emailChanged(email ?? '');
                                    return null;
                                  }));
                        },
                      ),

                      //todo Password Field
                      BlocBuilder<LoginCubit, LoginState>(
                        buildWhen: (previous, current) =>
                            previous.password != current.password,
                        builder: (context, state) {
                          return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  controller: passwordController,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                      icon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        child: Container(
                                          child: _obscureText == true
                                              ? const Icon(Icons.visibility_off)
                                              : const Icon(Icons.visibility),
                                        ),
                                      ),
                                      hintText: 'Password'),
                                  validator: (value) {
                                    InputDecoration(
                                        icon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _obscureText = !_obscureText;
                                            });
                                          },
                                          child: Container(
                                            child: _obscureText == true
                                                ? const Icon(
                                                    Icons.visibility_off)
                                                : const Icon(Icons.visibility),
                                          ),
                                        ),
                                        hintText: 'Password');
                                    return null;
                                  }));
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BlocBuilder<LoginCubit, LoginState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return ElevatedButton(
                                key: const Key(
                                    'loginForm_continue_raisedButton'),
                                style: ElevatedButton.styleFrom(),
                                // isLoading: state.status.isSubmissionInProgress
                                //     ? false
                                //     : (state.status.isValidated &&
                                //             !state.status.isSubmissionInProgress
                                //         ? false
                                //         : true),
                                // isOutline: state.status.isSubmissionInProgress
                                //     ? true
                                //     : false,

                                // cornerRadius: 5,
                                child: state.status.isSubmissionInProgress
                                    ? const Center(
                                        child: SizedBox(
                                            height: 30,
                                            width: 30,
                                            child: CircularProgressIndicator()),
                                      )
                                    : const Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                onPressed: () {
                                  context
                                      .read<LoginCubit>()
                                      .logInWithCredentials(
                                          emailController.text,
                                          passwordController.text);
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
