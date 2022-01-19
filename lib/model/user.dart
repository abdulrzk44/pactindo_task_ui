class User {
  User({
    required this.noKtp,
    required this.email,
    required this.noTelepon,
    required this.kodeOtp,
    required this.username,
    required this.password,
    required this.mpin,
  });
  late final String noKtp;
  late final String email;
  late final String noTelepon;
  late final String kodeOtp;
  late final String username;
  late final String password;
  late final String mpin;

  User.fromJson(Map<String, dynamic> json){
    noKtp = json['no_ktp'];
    email = json['email'];
    noTelepon = json['no_telepon'];
    kodeOtp = json['kode_otp'];
    username = json['username'];
    password = json['password'];
    mpin = json['mpin'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['no_ktp'] = noKtp;
    _data['email'] = email;
    _data['no_telepon'] = noTelepon;
    _data['kode_otp'] = kodeOtp;
    _data['username'] = username;
    _data['password'] = password;
    _data['mpin'] = mpin;
    return _data;
  }
}