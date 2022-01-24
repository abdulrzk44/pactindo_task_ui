import 'package:pactindo_task_ui/data/database/db_user.dart';
import 'package:pactindo_task_ui/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationRepository {
  final CrudUser _crudUser = CrudUser();

  Future<int> savePref(String username, String password) async {
    int result = 1;
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("username", username);
      result = (preferences.setString("password", password)) as int;
    } catch (e) {
      Exception(e);
    }
    return result;
  }

  Future<int> registrationSubmit({User? user}) async {
    int result = 1;
    try {
      result = await _crudUser.insert({
        "no_ktp": user!.noKtp!,
        "email": user.email!,
        "no_telepon": user.noTelepon!,
        "kode_otp": user.kodeOtp!,
        "username": user.username!,
        "password": user.password!,
        "mpin": user.mpin!,
      });
    } catch (e) {
      Exception(e);
    }
    return result;
  }
}
