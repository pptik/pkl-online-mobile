import 'package:pklonline/services/alert_service.dart';
import 'package:pklonline/services/api_service.dart';
import 'package:pklonline/services/ftp_service.dart';
import 'package:pklonline/services/geolocator_service.dart';
import 'package:pklonline/services/guid_service.dart';
import 'package:pklonline/services/navigation_service.dart';
import 'package:pklonline/services/permission_service.dart';
import 'package:pklonline/services/rmq_service.dart';
import 'package:pklonline/services/storage_service.dart';
import 'package:pklonline/services/vibrate_service.dart';
import 'package:get_it/get_it.dart';
import 'package:pklonline/services/location_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => GeolocatorService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => GuidService());
  locator.registerLazySingleton(() => StorageService());
  locator.registerLazySingleton(() => AlertService());
  locator.registerLazySingleton(() => VibrateService());
  locator.registerLazySingleton(() => FtpService());
  locator.registerLazySingleton(() => RMQService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => PermissionsService());
}
