//import 'package:eshifa_doc_pp/presentation/app/pages/diagnostic/view/audiogramReportScreen.dart';
import 'package:flutter/material.dart';
import 'package:from_login/login/view/login_form.dart';
import 'package:from_login/Helper/routesnames.dart';
import 'package:from_login/splash/splash.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashRoute:
      return MaterialPageRoute(builder: (context) => SplashPage());
    case LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());

    default:
      throw ('no route found');
  }
}

class LaboratoryRoute {}

class CustomMaterialPageRoute extends MaterialPageRoute {
  @override
  @protected
  bool get hasScopedWillPopCallback {
    return false;
  }

  CustomMaterialPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );
}
