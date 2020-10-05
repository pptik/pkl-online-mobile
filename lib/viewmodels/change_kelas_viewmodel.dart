import 'dart:io';

import 'package:pklonline/constants/const.dart';
import 'package:pklonline/constants/route_name.dart';
import 'package:pklonline/locator.dart';
import 'package:pklonline/services/alert_service.dart';
import 'package:pklonline/services/api_service.dart';
import 'package:pklonline/services/guid_service.dart';
import 'package:pklonline/services/navigation_service.dart';
import 'package:pklonline/services/storage_service.dart';
import 'package:pklonline/viewmodels/base_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class ChangeKelasViewModel extends BaseModel {
  final ApiService _apiService = locator<ApiService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AlertService _alertService = locator<AlertService>();
  final GuidService _guidService = locator<GuidService>();
  final StorageService _storageService = locator<StorageService>();

  List<String> units = List();
  String unitSelected;
  String company;
  String imagePath;

  void updateKelas(BuildContext context) async {
    setBusy(true);
    try {
      if (company.length != null &&
          unitSelected.length != null) {
        final companies = company;
        final guid = await _storageService.getString(K_GUID);
        final data = await _apiService.updateCompanyUnit(
          guid, 
          companies, 
          unitSelected);
        if (data.code == 200) {
          FocusScope.of(context).unfocus();
          setBusy(false);
          await _storageService.setString(K_COMPANY, companies);
          await _storageService.setString(K_UNIT, unitSelected);
          // navigate to home
          _alertService
            .showSuccess(context, "Success", "Successfully Updated", () {
              _navigationService.pop();
              _navigationService.popWithValue("update_sukses");
          });
        } else {
          setBusy(false);

          // User already registered
          _alertService.showError(context, 'Error',
              'Something went wrong ${data.message}', _navigationService.pop);
        }
      } else {
        setBusy(false);
        _alertService.showWarning(context, 'Warning',
            'Please fill in all fields', _navigationService.pop);
      }
    } catch (e) {
      _alertService.showError(
          context, 'Error', 'Please check once again', _navigationService.pop);
    }
    setBusy(false);
  }

  bool isPathNull() {
    if (imagePath == null || imagePath.isEmpty) {
      return false;
    }
    return true;
  }

  void onUnitChanged(String value) {
    unitSelected = value;
    setBusy(false);
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
