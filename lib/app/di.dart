import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_for_you/Features/home/model/home_repo.dart';
import 'package:taxi_for_you/Features/login/model/login_repo.dart';
import 'package:taxi_for_you/Features/lookups/model/lookups_repo.dart';
import 'package:taxi_for_you/Features/my_trips/model/my_trips_repo.dart';
import 'package:taxi_for_you/Features/otp/model/otp_repo.dart';
import 'package:taxi_for_you/Features/otp/view/verify_otp_viewmodel.dart';
import 'package:taxi_for_you/Features/registeration/models/registeration_repo.dart';
import 'package:taxi_for_you/Features/request_service/model/draft_trip_repo.dart';
import 'package:taxi_for_you/Features/trip_details/model/trip_details_repo.dart';
import '../Features/login/views/login_viewmodel.dart';
import '../Features/registeration/views/registeration_viewmodel.dart';
import '../Features/transportation_requests/model/transportation_repo.dart';
import '../core/network/http_base_request.dart';
import 'app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // instances
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  instance.registerFactory<HttpBaseRequest>(() => HttpBaseRequest());

  final baseRequestInterface = instance<HttpBaseRequest>();
  instance.registerFactory<LoginRepo>(
      () => LoginRepo(baseRequestInterface, instance<AppPreferences>()));
  instance.registerFactory<RegistrationRepo>(
    () => RegistrationRepo(baseRequestInterface),
  );
  instance.registerFactory<LookupsRepo>(
    () => LookupsRepo(baseRequestInterface),
  );
  instance.registerFactory<HomeRepo>(
    () => HomeRepo(baseRequestInterface, instance()),
  );
  instance.registerFactory<TripDetailsRepo>(
    () => TripDetailsRepo(baseRequestInterface),
  );
  instance.registerFactory<MyTripsRepo>(
    () => MyTripsRepo(baseRequestInterface),
  );
  instance.registerFactory<OtpRepo>(() => OtpRepo(baseRequestInterface));
  instance.registerFactory<TransportationRepo>(
      () => TransportationRepo(baseRequestInterface));
  instance.registerFactory<DraftTripRepo>(
      () => DraftTripRepo(baseRequestInterface));
}

initLoginModule() {
  if (!instance.isRegistered<LoginViewModel>()) {
    instance.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  }
}

initRegisterModule() {
  if (!instance.isRegistered<RegisterationViewModel>()) {
    instance.registerFactory<RegisterationViewModel>(
        () => RegisterationViewModel());
  }
}

initVerifyOtpModule() {
  if (!instance.isRegistered<VerifyOTPViewModel>()) {
    instance.registerFactory<VerifyOTPViewModel>(() => VerifyOTPViewModel());
  }
}
