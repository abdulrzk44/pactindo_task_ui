import 'package:pactindo_task_ui/data/database/db_user.dart';
import 'package:pactindo_task_ui/model/user.dart';

class AccountRepository {
  final CrudUser _crudUser = CrudUser();
  User? user;

  Future<bool> checkUser() async {
    bool result = false;
    try {
      await _crudUser.getData().then((value) {
        value.forEach((element) {
          user = User.fromJson(element);
        });
      });
      if (user == null) {
        result = false;
      } else {
        result = true;
      }
    } catch (e) {
      Exception(e);
    }
    return result;
  }
}
