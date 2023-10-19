import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:from_login/authentication_repository.dart';
import 'package:from_login/Helper/routesnames.dart';
import 'package:from_login/splash/view/splash_page.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'login/bloc/login_bloc.dart';
import 'login/view/login_form.dart';
import 'Helper/NavigationServices.dart';
import 'Helper/generateRoute.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(authenticationRepository: AuthenticationRepository())),
    storage: storage,
  );
}

class MyApp extends StatefulWidget {
  final AuthenticationRepository authenticationRepository;

  const MyApp({Key? key, required this.authenticationRepository})
      : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: widget.authenticationRepository,
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => LoginCubit(
                      widget.authenticationRepository,
                    ))
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: generateRoute,
              navigatorKey: NavigationService.instance.navigatorKey,
              initialRoute: LoginRoute)),
    );
  }
}
