import 'package:pklonline/constants/const.dart';
import 'package:pklonline/constants/route_name.dart';
import 'package:pklonline/locator.dart';
import 'package:pklonline/services/navigation_service.dart';
import 'package:pklonline/services/storage_service.dart';
import 'package:pklonline/viewmodels/base_model.dart';

class ProfileViewModel extends BaseModel {
  final StorageService _storageService = locator<StorageService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String image = '';
  String name = '';
  String phoneNumber = '';
  String email = '';
  String unit = '';

  void initClass() {
    print('init');
    loadProfile();
  }

  void goToEditProfile() {
    _navigationService.navigateTo(EditProfileRoute);
  }

  void loadProfile() async {
    setBusy(true);
    var tempImage = await _storageService.getString(K_IMAGE);
    var tempLocal = await _storageService.getString(K_LOCAL_IMAGE);
    name = await _storageService.getString(K_NAME);
    print('name $name');
    phoneNumber = await _storageService.getString(K_PHONE_NUMBER);
    email = await _storageService.getString(K_EMAIL);
    unit = await _storageService.getString(K_UNIT);
    image = 'http://pklonline.pptik.id/data/kehadiran/image/' + tempImage;
    print('the image $image and $tempImage');
    setBusy(false);
  }

  void goToChangePassword() {
    _navigationService.navigateTo(EditChangePwRoute);
  }
}
