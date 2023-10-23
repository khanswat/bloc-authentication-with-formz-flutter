import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:from_login/Helper/NavigationServices.dart';
import 'package:from_login/Helper/routesnames.dart';
import 'package:from_login/login/bloc/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/bloc/login_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
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
                        'Log out',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                onPressed: () async {
                  var sharedPrefs = await SharedPreferences.getInstance();
                  await sharedPrefs.remove('token');
                  NavigationService.instance.pushAndReplac(LoginRoute1);
                });
          },
        ),
      ),
    );
  }
}
