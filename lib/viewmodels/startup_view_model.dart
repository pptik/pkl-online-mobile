import 'dart:async';

import 'package:pklonline/constants/const.dart';
import 'package:pklonline/constants/route_name.dart';
import 'package:pklonline/locator.dart';
import 'package:pklonline/services/navigation_service.dart';
import 'package:pklonline/services/permission_service.dart';
import 'package:pklonline/services/storage_service.dart';
import 'package:pklonline/viewmodels/base_model.dart';

class StartUpViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final StorageService _storageService = locator<StorageService>();
  final PermissionsService _permissionsService = locator<PermissionsService>();

  checkPermission() async{
    var _check = _permissionsService.checkStatus();
    print("data _ $_check");
  }
  startTimer() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, handleStartUpLogic);
  }

  Future handleStartUpLogic() async {
    final data = await _storageService.getString(K_GUID);

    if (data == null) {
      _navigationService.replaceTo(LoginViewRoute);
    } else {
      _navigationService.replaceTo(HomeViewRoute);
    }
  }
}
