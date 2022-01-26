import 'package:flutter_biometrics/flutter_biometrics.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<List<String>> getDataLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return [
      preferences.getString("username") ?? "user_null",
      preferences.getString("password") ?? "pwd_null"
    ];
  }

  Future<String> getBiometricLogin() async {
    var biometrics = FlutterBiometrics();
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String publicKeyAsBase64 = preferences.getString("biometricKey") ?? "";

    if(publicKeyAsBase64 == ""){
      publicKeyAsBase64 =
      await biometrics.createKeys(reason: 'Daftarkan sidik jari');

      preferences.setString("biometricKey", publicKeyAsBase64);
    }

    String signedPayloadAsBase64 = await biometrics.sign(
        payload: publicKeyAsBase64, reason: 'Verifikasi sidik jari') as String;

    return signedPayloadAsBase64;
  }
}
