import 'package:pactindo_task_ui/data/database/db_user.dart';

class CheckAccountRepository {
  final CrudUser _crudUser = CrudUser();

  Future<bool> checkAccount() async {
    bool result = false;
    try {
      await _crudUser.checkDB().then((value) {
        print("VALUEEE : $value");
        result = value;
      });
      return result;
    } catch (e) {
      Exception(e);
    }
    return result;
  }
}
