class UserQuery {
  static const String TABLE_NAME = "user";
  static const String CREATE_TABLE =
      " CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY AUTOINCREMENT, no_ktp TEXT , email TEXT, no_telepon TEXT , kode_otp TEXT, username TEXT , password TEXT, mpin TEXT ) ";
  static const String SELECT = "select * from $TABLE_NAME";
}
