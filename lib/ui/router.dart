import 'package:flutter/material.dart';
import 'package:pklonline/constants/route_name.dart';
import 'package:pklonline/ui/views/absen_view.dart';
import 'package:pklonline/ui/views/camera_view.dart';
import 'package:pklonline/ui/views/change_pw_view.dart';
import 'package:pklonline/ui/views/home_view.dart';
import 'package:pklonline/ui/views/login_view.dart';
import 'package:pklonline/ui/views/profile_view.dart';
import 'package:pklonline/ui/views/signup_view.dart';
import 'package:pklonline/ui/views/forgot_pw_view.dart';
import 'package:pklonline/ui/views/change_kelas_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case ProfileViewRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: ProfileView(),
      );
    case AbsenViewRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: AbsenView(),
      );
    case CameraViewRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: CameraView(),
      );
//    case EditProfileRoute:
//      return _pageRoute(
//        routeName: settings.name,
//        viewToShow: EditProfileView(),
//      );
    case EditChangePwRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: EditPasswordView(),
      );
    case EditKelasRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: ChangeKelasView(),
      );
    case ForgotPwRoute:
      return _pageRoute(
        routeName: settings.name,
        viewToShow: ForgotPwView(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text(
              'No route defined for ${settings.name}',
            ),
          ),
        ),
      );
  }
}

PageRoute _pageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}
