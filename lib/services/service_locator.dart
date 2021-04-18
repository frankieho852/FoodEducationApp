
import 'package:food_education_app/auth/screens/login/login_page_logic.dart';
import 'package:food_education_app/auth/screens/signup/signup_page_logic.dart';
import 'package:get_it/get_it.dart';

import '../auth_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => LoginPageLogic());

  getIt.registerLazySingleton(() => AuthService());

  getIt.registerLazySingleton(() => SignUpPageLogic());
}
