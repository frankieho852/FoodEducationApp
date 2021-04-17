
import 'package:food_education_app/screens/login/login_page_logic.dart';
import 'package:get_it/get_it.dart';

import '../auth_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => LoginPageLogic());

  getIt.registerLazySingleton(() => AuthService());
}
