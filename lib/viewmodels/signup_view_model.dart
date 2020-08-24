import 'dart:convert';
import 'dart:io';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:pklonline/constants/helper.dart';
import 'package:pklonline/constants/route_name.dart';
import 'package:pklonline/locator.dart';
import 'package:pklonline/services/alert_service.dart';
import 'package:pklonline/services/api_service.dart';
import 'package:pklonline/services/guid_service.dart';
import 'package:pklonline/services/navigation_service.dart';
import 'package:pklonline/services/storage_service.dart';
import 'package:pklonline/viewmodels/base_model.dart';

class SignUpViewModel extends BaseModel {
  final ApiService _apiService = locator<ApiService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AlertService _alertService = locator<AlertService>();
  final GuidService _guidService = locator<GuidService>();
  final StorageService _storageService = locator<StorageService>();

  List<String> units = List();
  List<String> profesi = List();
  List<String> areasList = List();
  List<Item> areaForDistrcit = List();
  List<dynamic> districts = List();
  List<String> jurusanList = List();

  String unitSelected;
  String profesiSelected = "PKL ONLINE";
  String areasSelected;
  String districtSelected;
  String jurusanSelected;
  String company = "PKLO1";
  String imagePath;

  bool eula = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberCotroller = TextEditingController();
  TextEditingController idCardController = TextEditingController();

  void showEulas(BuildContext context) {
    _alertService.showSuccess(
        context,
        "AMARI COVID19 End-User License Agreement \n (\"Agreement\")",
        Helper.eula_content,
        _navigationService.pop);
  }

  void onChangeEula(bool value) {
    eula = value;
  }

  Future<String> loadAsset() async {
    final a = await rootBundle.loadString('assets/level1.csv');
    final ab = json.decode(a);
    print(ab[0]);
    print(ab);
  }

  void register(BuildContext context) async {
    setBusy(true);
    print('ini adalah image path $imagePath');
    try {
      if (nameController.text.length != null &&
          positionController.text.length != null &&
          emailController.text.length != null &&
          passwordController.text.length != null &&
          phoneNumberCotroller.text.length != null &&
          company.length != null &&
          imagePath.length != null &&
          profesiSelected != null) {
        final name = nameController.text;
        final email = emailController.text;
        final position = positionController.text;
        final password = passwordController.text;
        final phoneNumber = phoneNumberCotroller.text;
        final idCard = idCardController.text;
        final companies = company;
        print(companies);
        print(profesiSelected);
        final data = await _apiService.register(
          name,
          email,
          password,
          profesiSelected,
          idCard,
          companies,
          imagePath,
          profesiSelected,
          phoneNumber,
          File(imagePath),
        );

        if (data.code == 200) {
          setBusy(false);

          // navigate to home
          _navigationService.replaceTo(LoginViewRoute);
        } else {
          setBusy(false);

          // User already registered
          _alertService.showError(context, 'Error',
              'Something went wrong ' + data.message, _navigationService.pop);
        }
      } else {
        setBusy(false);
        _alertService.showWarning(context, 'Warning',
            'Please fill in all fields', _navigationService.pop);
      }
    } catch (e) {
      print(e.toString());
      _alertService.showError(context, 'Error',
          'Please check once again ${e.toString()}', _navigationService.pop);
    }
    setBusy(false);
  }

  bool isPathNull() {
    if (imagePath == null || imagePath.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> cameraView() async {
    final path = await _navigationService.navigateTo(CameraViewRoute);
    imagePath = path.toString().split('#')[0];
  }

  void onUnitChanged(String value) {
    unitSelected = value;
    setBusy(false);
  }

  void getDistrict(String value) {
    districts.clear();
    jurusanList.clear();
    districtSelected = null;
    jurusanSelected = null;
//    print(areaForDistrcit.where((element) => element.areasDistrict==value).toList());
//
//    List<Item> data = areaForDistrcit.where((element) => element.areasDistrict==value).toList();
//    districts.addAll(data)
    for (int i = 0; i < areaForDistrcit.length; i++) {
      if (areaForDistrcit[i].areasDistrict == value) {
        districts.addAll(areaForDistrcit[i].district);
      }
    }
  }

  void onJurusanChanged(String value) {
    jurusanSelected = value;
    setBusy(false);
    company = value.split('-')[1];
    print(value.split('-')[1]);
  }

  bool changeVisibilityDistrict() {
    if (districts == null || districts.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool changeVisibilityAreas() {
    if (areasList == null || areasList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool changeVisibility() {
    if (units == null || units.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void getCompanyUnit(String code) async {
    setBusy(false);
    unitSelected = null;
    units.clear();

    final unit = await _apiService.getCompanyUnit(code);
    if (unit != null) {
      unit.data.forEach(
        (value) {
          units.add(value);
        },
      );
    }

    setBusy(false);
    print('units => $units');
    print('visi => ${changeVisibility()}');
  }
}

class Item {
  String areasDistrict;
  List district;
  Item(this.areasDistrict, this.district);
}
