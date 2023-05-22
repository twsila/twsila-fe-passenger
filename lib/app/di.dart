import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_for_you/Features/login/model/login_repo.dart';
import 'package:taxi_for_you/Features/otp/model/otp_repo.dart';
import 'package:taxi_for_you/Features/otp/view/verify_otp_viewmodel.dart';
import '../Features/login/views/login_viewmodel.dart';
import '../Features/register/views/register_viewmodel.dart';
import '../core/network/http_base_request.dart';
import 'app_prefs.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));
  instance.registerFactory<HttpBaseRequest>(() => HttpBaseRequest());
  instance
      .registerFactory<LoginRepo>(() => LoginRepo(instance<HttpBaseRequest>()));
  instance.registerFactory<OtpRepo>(() => OtpRepo(instance<HttpBaseRequest>()));
}

initLoginModule() {
  if (!instance.isRegistered<LoginViewModel>()) {
    instance.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  }
}

initRegisterModule() {
  instance.registerFactory<RegisterViewModel>(() => RegisterViewModel());
}

initVerifyOtpModule() {
  if (!instance.isRegistered<VerifyOTPViewModel>()) {
    instance.registerFactory<VerifyOTPViewModel>(() => VerifyOTPViewModel());
  }
}
