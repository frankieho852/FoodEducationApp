import 'package:fyp_firebase_login/screens/login/login_page_logic.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<LoginPageLogic>(LoginPageLogic());
}
