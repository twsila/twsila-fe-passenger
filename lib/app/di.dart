import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_for_you/Features/otp/view/verify_otp_viewmodel.dart';
import '../Features/login/login_viewmodel.dart';
import '../Features/register/views/register_viewmodel.dart';
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
}

initLoginModule() {
  instance.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
}

initRegisterModule() {
  instance.registerFactory<RegisterViewModel>(() => RegisterViewModel());
}

initVerifyOtpModule() {
  // if (!GetIt.I.isRegistered<GenerateOtpUseCase>()) {
  //   instance.registerFactory<GenerateOtpUseCase>(
  //       () => GenerateOtpUseCase(instance()));
  //   instance
  //       .registerFactory<VerifyOtpUseCase>(() => VerifyOtpUseCase(instance()));
  instance.registerFactory<VerifyOTPViewModel>(() => VerifyOTPViewModel());
}
