import 'package:pactindo_task_ui/data/database/db_user.dart';
import 'package:pactindo_task_ui/model/user.dart';

class RegistrationRepository {
  final CrudUser _crudUser = CrudUser();

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
